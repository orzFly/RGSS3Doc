#encoding:utf-8
# 战斗画面中，选择角色行动的窗口。
class Window_ActorCommand < Window_Command
    # 初始化对象
    def initialize
    super(0, 0)
    self.openness = 0
    deactivate
    @actor = nil
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
    return unless @actor
    add_attack_command
    add_skill_commands
    add_guard_command
    add_item_command
  end
    # 添加攻击指令
    def add_attack_command
    add_command(Vocab::attack, :attack, @actor.attack_usable?)
  end
    # 添加技能指令
    def add_skill_commands
    @actor.added_skill_types.sort.each do |stype_id|
      name = $data_system.skill_types[stype_id]
      add_command(name, :skill, true, stype_id)
    end
  end
    # 添加防御指令
    def add_guard_command
    add_command(Vocab::guard, :guard, @actor.guard_usable?)
  end
    # 添加物品指令
    def add_item_command
    add_command(Vocab::item, :item)
  end
    # 设置
    def setup(actor)
    @actor = actor
    clear_command_list
    make_command_list
    refresh
    select(0)
    activate
    open
  end
end
