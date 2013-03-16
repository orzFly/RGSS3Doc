#encoding:utf-8
# 拥有光标移动、滚动功能的窗口
class Window_Selectable < Window_Base
    # 定义实例变量
    attr_reader   :index                    # 光标位置
  attr_reader   :help_window              # 帮助窗口
  attr_accessor :cursor_fix               # 光标固定的标志
  attr_accessor :cursor_all               # 光标全选择的标志
    # 初始化对象
    def initialize(x, y, width, height)
    super
    @index = -1
    @handler = {}
    @cursor_fix = false
    @cursor_all = false
    update_padding
    deactivate
  end
    # 获取列数
    def col_max
    return 1
  end
    # 获取行间距的宽度
    def spacing
    return 32
  end
    # 获取项目数
    def item_max
    return 0
  end
    # 获取项目的宽度
    def item_width
    (width - standard_padding * 2 + spacing) / col_max - spacing
  end
    # 获取项目的高度
    def item_height
    line_height
  end
    # 获取行数
    def row_max
    [(item_max + col_max - 1) / col_max, 1].max
  end
    # 计算窗口内容的高度
    def contents_height
    [super - super % item_height, row_max * item_height].max
  end
    # 更新边距
    def update_padding
    super
    update_padding_bottom
  end
    # 更新下端边距
    def update_padding_bottom
    surplus = (height - standard_padding * 2) % item_height
    self.padding_bottom = padding + surplus
  end
    # 设置高度
    def height=(height)
    super
    update_padding
  end
    # 更改启用状态
    def active=(active)
    super
    update_cursor
    call_update_help
  end
    # 设置光标位置
    def index=(index)
    @index = index
    update_cursor
    call_update_help
  end
    # 选择项目
    def select(index)
    self.index = index if index
  end
    # 解除项目的选择
    def unselect
    self.index = -1
  end
    # 获取当前行
    def row
    index / col_max
  end
    # 获取顶行位置
    def top_row
    oy / item_height
  end
    # 设置顶行位置
    def top_row=(row)
    row = 0 if row < 0
    row = row_max - 1 if row > row_max - 1
    self.oy = row * item_height
  end
    # 获取一页內显示的行数
    def page_row_max
    (height - padding - padding_bottom) / item_height
  end
    # 获取一页內显示的项目数
    def page_item_max
    page_row_max * col_max
  end
    # 判定是否横向选择
    def horizontal?
    page_row_max == 1
  end
    # 获取末行位置
    def bottom_row
    top_row + page_row_max - 1
  end
    # 设置末行位置
    def bottom_row=(row)
    self.top_row = row - (page_row_max - 1)
  end
    # 获取项目的绘制矩形
    def item_rect(index)
    rect = Rect.new
    rect.width = item_width
    rect.height = item_height
    rect.x = index % col_max * (item_width + spacing)
    rect.y = index / col_max * item_height
    rect
  end
    # 获取项目的绘制矩形（内容用）
    def item_rect_for_text(index)
    rect = item_rect(index)
    rect.x += 4
    rect.width -= 8
    rect
  end
    # 设置帮助窗口
    def help_window=(help_window)
    @help_window = help_window
    call_update_help
  end
    # 设置动作对应的处理方法
  # method : 设置的处理方法 (Method 实例)
    def set_handler(symbol, method)
    @handler[symbol] = method
  end
    # 确认处理方法是否存在
    def handle?(symbol)
    @handler.include?(symbol)
  end
    # 调用处理方法
    def call_handler(symbol)
    @handler[symbol].call if handle?(symbol)
  end
    # 判定光标是否可以移动
    def cursor_movable?
    active && open? && !@cursor_fix && !@cursor_all && item_max > 0
  end
    # 光标向下移动
    def cursor_down(wrap = false)
    if index < item_max - col_max || (wrap && col_max == 1)
      select((index + col_max) % item_max)
    end
  end
    # 光标向上移动
    def cursor_up(wrap = false)
    if index >= col_max || (wrap && col_max == 1)
      select((index - col_max + item_max) % item_max)
    end
  end
    # 光标向右移动
    def cursor_right(wrap = false)
    if col_max >= 2 && (index < item_max - 1 || (wrap && horizontal?))
      select((index + 1) % item_max)
    end
  end
    # 光标向左移动
    def cursor_left(wrap = false)
    if col_max >= 2 && (index > 0 || (wrap && horizontal?))
      select((index - 1 + item_max) % item_max)
    end
  end
    # 光标移至下一页
    def cursor_pagedown
    if top_row + page_row_max < row_max
      self.top_row += page_row_max
      select([@index + page_item_max, item_max - 1].min)
    end
  end
    # 光标移至上一页
    def cursor_pageup
    if top_row > 0
      self.top_row -= page_row_max
      select([@index - page_item_max, 0].max)
    end
  end
    # 更新画面
    def update
    super
    process_cursor_move
    process_handling
  end
    # 处理光标的移动
    def process_cursor_move
    return unless cursor_movable?
    last_index = @index
    cursor_down (Input.trigger?(:DOWN))  if Input.repeat?(:DOWN)
    cursor_up   (Input.trigger?(:UP))    if Input.repeat?(:UP)
    cursor_right(Input.trigger?(:RIGHT)) if Input.repeat?(:RIGHT)
    cursor_left (Input.trigger?(:LEFT))  if Input.repeat?(:LEFT)
    cursor_pagedown   if !handle?(:pagedown) && Input.trigger?(:R)
    cursor_pageup     if !handle?(:pageup)   && Input.trigger?(:L)
    Sound.play_cursor if @index != last_index
  end
    # “确定”和“取消”的处理
    def process_handling
    return unless open? && active
    return process_ok       if ok_enabled?        && Input.trigger?(:C)
    return process_cancel   if cancel_enabled?    && Input.trigger?(:B)
    return process_pagedown if handle?(:pagedown) && Input.trigger?(:R)
    return process_pageup   if handle?(:pageup)   && Input.trigger?(:L)
  end
    # 获取确定处理的有效状态
    def ok_enabled?
    handle?(:ok)
  end
    # 获取取消处理的有效状态
    def cancel_enabled?
    handle?(:cancel)
  end
    # 按下确定键时的处理
    def process_ok
    if current_item_enabled?
      Sound.play_ok
      Input.update
      deactivate
      call_ok_handler
    else
      Sound.play_buzzer
    end
  end
    # 调用“确定”的处理方法
    def call_ok_handler
    call_handler(:ok)
  end
    # 按下取消键时的处理
    def process_cancel
    Sound.play_cancel
    Input.update
    deactivate
    call_cancel_handler
  end
    # 调用“取消”的处理方法
    def call_cancel_handler
    call_handler(:cancel)
  end
    # 按下 L 键（PageUp）时的处理
    def process_pageup
    Sound.play_cursor
    Input.update
    deactivate
    call_handler(:pageup)
  end
    # 按下 R 键（PageDown）时的处理
    def process_pagedown
    Sound.play_cursor
    Input.update
    deactivate
    call_handler(:pagedown)
  end
    # 更新光标
    def update_cursor
    if @cursor_all
      cursor_rect.set(0, 0, contents.width, row_max * item_height)
      self.top_row = 0
    elsif @index < 0
      cursor_rect.empty
    else
      ensure_cursor_visible
      cursor_rect.set(item_rect(@index))
    end
  end
    # 确保光标在画面范围内滚动
    def ensure_cursor_visible
    self.top_row = row if row < top_row
    self.bottom_row = row if row > bottom_row
  end
    # 调用帮助窗口的更新方法
    def call_update_help
    update_help if active && @help_window
  end
    # 更新帮助窗口
    def update_help
    @help_window.clear
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    return true
  end
    # 绘制所有项目
    def draw_all_items
    item_max.times {|i| draw_item(i) }
  end
    # 绘制项目
    def draw_item(index)
  end
    # 消除项目
    def clear_item(index)
    contents.clear_rect(item_rect(index))
  end
    # 重绘项目
    def redraw_item(index)
    clear_item(index) if index >= 0
    draw_item(index)  if index >= 0
  end
    # 重绘选择项目
    def redraw_current_item
    redraw_item(@index)
  end
    # 刷新
    def refresh
    contents.clear
    draw_all_items
  end
end
