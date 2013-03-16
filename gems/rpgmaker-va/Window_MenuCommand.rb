#encoding:utf-8
# 菜单画面中显示指令的窗口
class Window_MenuCommand < Window_Command
    # 初始化指令选择位置（类方法）
    def self.init_command_position
    @@last_command_symbol = nil
  end
    # 初始化对象
    def initialize
    super(0, 0)
    select_last
  end
    # 获取窗口的宽度
    def window_width
    return 160
  end
    # 获取显示行数
    def visible_line_number
    item_max
  end
    # 生成指令列表
    def make_command_list
    add_main_commands
    add_formation_command
    add_original_commands
    add_save_command
    add_game_end_command
  end
    # 向指令列表添加主要的指令
    def add_main_commands
    add_command(Vocab::item,   :item,   main_commands_enabled)
    add_command(Vocab::skill,  :skill,  main_commands_enabled)
    add_command(Vocab::equip,  :equip,  main_commands_enabled)
    add_command(Vocab::status, :status, main_commands_enabled)
  end
    # 添加整队指令
    def add_formation_command
    add_command(Vocab::formation, :formation, formation_enabled)
  end
    # 独自添加指令用
    def add_original_commands
  end
    # 添加存档指令
    def add_save_command
    add_command(Vocab::save, :save, save_enabled)
  end
    # 添加游戏结束指令
    def add_game_end_command
    add_command(Vocab::game_end, :game_end)
  end
    # 获取主要指令的有效状态
    def main_commands_enabled
    $game_party.exists
  end
    # 获取整队的有效状态
    def formation_enabled
    $game_party.members.size >= 2 && !$game_system.formation_disabled
  end
    # 获取存档的有效状态
    def save_enabled
    !$game_system.save_disabled
  end
    # 按下确定键时的处理
    def process_ok
    @@last_command_symbol = current_symbol
    super
  end
    # 返回最后一个选项的位置
    def select_last
    select_symbol(@@last_command_symbol)
  end
end
