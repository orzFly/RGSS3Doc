#encoding:utf-8
# 带有指令选择的窗口
class Window_Command < Window_Selectable
    # 初始化对象
    def initialize(x, y)
    clear_command_list
    make_command_list
    super(x, y, window_width, window_height)
    refresh
    select(0)
    activate
  end
    # 获取窗口的宽度
    def window_width
    return 160
  end
    # 获取窗口的高度
    def window_height
    fitting_height(visible_line_number)
  end
    # 获取显示行数
    def visible_line_number
    item_max
  end
    # 获取项目数
    def item_max
    @list.size
  end
    # 清除指令列表
    def clear_command_list
    @list = []
  end
    # 生成指令列表
    def make_command_list
  end
    # 添加指令
    # name    : 指令名称
    # symbol  : 对应的符号
    # enabled : 有效状态的标志
    # ext     : 任意的扩展数据
    def add_command(name, symbol, enabled = true, ext = nil)
    @list.push({:name=>name, :symbol=>symbol, :enabled=>enabled, :ext=>ext})
  end
    # 获取指令名称
    def command_name(index)
    @list[index][:name]
  end
    # 获取指令的有效状态
    def command_enabled?(index)
    @list[index][:enabled]
  end
    # 获取选项的指令数据
    def current_data
    index >= 0 ? @list[index] : nil
  end
    # 获取选项的有效状态
    def current_item_enabled?
    current_data ? current_data[:enabled] : false
  end
    # 获取选项的符号
    def current_symbol
    current_data ? current_data[:symbol] : nil
  end
    # 获取选项的扩展数据
    def current_ext
    current_data ? current_data[:ext] : nil
  end
    # 将光标移动到指定的标志符对应的选项
    def select_symbol(symbol)
    @list.each_index {|i| select(i) if @list[i][:symbol] == symbol }
  end
    # 将光标移动到指定的扩展数据对应的选项
    def select_ext(ext)
    @list.each_index {|i| select(i) if @list[i][:ext] == ext }
  end
    # 绘制项目
    def draw_item(index)
    change_color(normal_color, command_enabled?(index))
    draw_text(item_rect_for_text(index), command_name(index), alignment)
  end
    # 获取对齐方向
    def alignment
    return 0
  end
    # 获取决定处理的有效状态
    def ok_enabled?
    return true
  end
    # 调用“确定”的处理方法
    def call_ok_handler
    if handle?(current_symbol)
      call_handler(current_symbol)
    elsif handle?(:ok)
      super
    else
      activate
    end
  end
    # 刷新
    def refresh
    clear_command_list
    make_command_list
    create_contents
    super
  end
end
