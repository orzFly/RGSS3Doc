#encoding:utf-8
# 战斗画面中，选择“战斗／撤退”的窗口。
class Window_PartyCommand < Window_Command
    # 初始化对象
    def initialize
    super(0, 0)
    self.openness = 0
    deactivate
  end
    # 获取窗口的宽度
    def window_width
    return 128
  end
    # 获取显示行数
    def visible_line_number
    return 4
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::fight,  :fight)
    add_command(Vocab::escape, :escape, BattleManager.can_escape?)
  end
    # 设置
    def setup
    clear_command_list
    make_command_list
    refresh
    select(0)
    activate
    open
  end
end
