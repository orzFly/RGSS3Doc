#encoding:utf-8
# 技能画面中，选择指令（特技／魔法等）的窗口。
class Window_SkillCommand < Window_Command
    # 定义实例变量
    attr_reader   :skill_window
    # 初始化对象
    def initialize(x, y)
    super(x, y)
    @actor = nil
  end
    # 获取窗口的宽度
    def window_width
    return 160
  end
    # 设置角色
    def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
    select_last
  end
    # 获取显示行数
    def visible_line_number
    return 4
  end
    # 生成指令列表
    def make_command_list
    return unless @actor
    @actor.added_skill_types.sort.each do |stype_id|
      name = $data_system.skill_types[stype_id]
      add_command(name, :skill, true, stype_id)
    end
  end
    # 更新画面
    def update
    super
    @skill_window.stype_id = current_ext if @skill_window
  end
    # 设置技能窗口
    def skill_window=(skill_window)
    @skill_window = skill_window
    update
  end
    # 返回上一个选择的位置
    def select_last
    skill = @actor.last_skill.object
    if skill
      select_ext(skill.stype_id)
    else
      select(0)
    end
  end
end
