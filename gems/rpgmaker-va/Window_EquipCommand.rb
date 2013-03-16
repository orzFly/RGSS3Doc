#encoding:utf-8
# 技能画面中，选择指令（更换装备／最强装备／全部卸下）的窗口。
class Window_EquipCommand < Window_HorzCommand
    # 初始化对象
    def initialize(x, y, width)
    @window_width = width
    super(x, y)
  end
    # 获取窗口的宽度
    def window_width
    @window_width
  end
    # 获取列数
    def col_max
    return 3
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::equip2,   :equip)
    add_command(Vocab::optimize, :optimize)
    add_command(Vocab::clear,    :clear)
  end
end
