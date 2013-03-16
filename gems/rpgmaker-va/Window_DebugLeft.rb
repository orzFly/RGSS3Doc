#encoding:utf-8
# 调试画面中，显示开关和变量编号的窗口。
class Window_DebugLeft < Window_Selectable
    # 类变量
    @@last_top_row = 0                      # 保存顶行用
  @@last_index   = 0                      # 保存光标位置用
    # 定义实例变量
    attr_reader   :right_window             # 右窗口
    # 初始化对象
    def initialize(x, y)
    super(x, y, window_width, window_height)
    refresh
    self.top_row = @@last_top_row
    select(@@last_index)
    activate
  end
    # 获取窗口的宽度
    def window_width
    return 164
  end
    # 获取窗口的高度
    def window_height
    Graphics.height
  end
    # 获取项目数
    def item_max
    @item_max || 0
  end
    # 更新画面
    def update
    super
    return unless @right_window
    @right_window.mode = mode
    @right_window.top_id = top_id
  end
    # 获取模式
    def mode
    index < @switch_max ? :switch : :variable
  end
    # 获取顶端 ID 
    def top_id
    (index - (index < @switch_max ? 0 : @switch_max)) * 10 + 1
  end
    # 刷新
    def refresh
    @switch_max = ($data_system.switches.size - 1 + 9) / 10
    @variable_max = ($data_system.variables.size - 1 + 9) / 10
    @item_max = @switch_max + @variable_max
    create_contents
    draw_all_items
  end
    # 绘制项目
    def draw_item(index)
    if index < @switch_max
      n = index * 10
      text = sprintf("S [%04d-%04d]", n+1, n+10)
    else
      n = (index - @switch_max) * 10
      text = sprintf("V [%04d-%04d]", n+1, n+10)
    end
    draw_text(item_rect_for_text(index), text)
  end
    # 按下取消键时的处理
    def process_cancel
    super
    @@last_top_row = top_row
    @@last_index = index
  end
    # 设置右窗口
    def right_window=(right_window)
    @right_window = right_window
    update
  end
end
