#encoding:utf-8
# 名字输入画面中，编辑名字的窗口。
class Window_NameEdit < Window_Base
    # 定义实例变量
    attr_reader   :name                     # 名字
  attr_reader   :index                    # 光标位置
  attr_reader   :max_char                 # 最大文字数
    # 初始化对象
    def initialize(actor, max_char)
    x = (Graphics.width - 360) / 2
    y = (Graphics.height - (fitting_height(4) + fitting_height(9) + 8)) / 2
    super(x, y, 360, fitting_height(4))
    @actor = actor
    @max_char = max_char
    @default_name = @name = actor.name[0, @max_char]
    @index = @name.size
    deactivate
    refresh
  end
    # 恢复默认的名字
    def restore_default
    @name = @default_name
    @index = @name.size
    refresh
    return !@name.empty?
  end
    # 添加文字
  # ch : 添加的文字
    def add(ch)
    return false if @index >= @max_char
    @name += ch
    @index += 1
    refresh
    return true
  end
    # 后退一个字符
    def back
    return false if @index == 0
    @index -= 1
    @name = @name[0, @index]
    refresh
    return true
  end
    # 获取肖像的宽度
    def face_width
    return 96
  end
    # 获取文字的宽度
    def char_width
    text_size($game_system.japanese? ? "あ" : "A").width 
  end
    # 获取名字绘制的左端坐标
    def left
    name_center = (contents_width + face_width) / 2
    name_width = (@max_char + 1) * char_width
    return [name_center - name_width / 2, contents_width - name_width].min
  end
    # 获取项目的绘制矩形
    def item_rect(index)
    Rect.new(left + index * char_width, 36, char_width, line_height)
  end
    # 获取下划线的矩形
    def underline_rect(index)
    rect = item_rect(index)
    rect.x += 1
    rect.y += rect.height - 4
    rect.width -= 2
    rect.height = 2
    rect
  end
    # 获取下划线的颜色
    def underline_color
    color = normal_color
    color.alpha = 48
    color
  end
    # 绘制下划线
    def draw_underline(index)
    contents.fill_rect(underline_rect(index), underline_color)
  end
    # 绘制文字
    def draw_char(index)
    rect = item_rect(index)
    rect.x -= 1
    rect.width += 4
    change_color(normal_color)
    draw_text(rect, @name[index] || "")
  end
    # 刷新
    def refresh
    contents.clear
    draw_actor_face(@actor, 0, 0)
    @max_char.times {|i| draw_underline(i) }
    @name.size.times {|i| draw_char(i) }
    cursor_rect.set(item_rect(@index))
  end
end
