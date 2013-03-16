#encoding:utf-8
# 显示特技和物品等的说明、以及角色状态的窗口
class Window_Help < Window_Base
    # 初始化对象
    def initialize(line_number = 2)
    super(0, 0, Graphics.width, fitting_height(line_number))
  end
    # 设置内容
    def set_text(text)
    if text != @text
      @text = text
      refresh
    end
  end
    # 清除
    def clear
    set_text("")
  end
    # 设置物品
  # item : 技能、物品等
    def set_item(item)
    set_text(item ? item.description : "")
  end
    # 刷新
    def refresh
    contents.clear
    draw_text_ex(4, 0, @text)
  end
end
