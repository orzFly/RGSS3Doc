#encoding:utf-8
# 技能画面中，显示技能的窗口。
class Window_SkillList < Window_Selectable
    # 初始化对象
    def initialize(x, y, width, height)
    super
    @actor = nil
    @stype_id = 0
    @data = []
  end
    # 设置角色
    def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
    self.oy = 0
  end
    # 设置技能类型 ID 
    def stype_id=(stype_id)
    return if @stype_id == stype_id
    @stype_id = stype_id
    refresh
    self.oy = 0
  end
    # 获取列数
    def col_max
    return 2
  end
    # 获取项目数
    def item_max
    @data ? @data.size : 1
  end
    # 获取技能
    def item
    @data && index >= 0 ? @data[index] : nil
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    enable?(@data[index])
  end
    # 查询列表中是否含有此技能
    def include?(item)
    item && item.stype_id == @stype_id
  end
    # 查询此技能是否可用
    def enable?(item)
    @actor && @actor.usable?(item)
  end
    # 生成技能列表
    def make_item_list
    @data = @actor ? @actor.skills.select {|skill| include?(skill) } : []
  end
    # 返回上一个选择的位置
    def select_last
    select(@data.index(@actor.last_skill.object) || 0)
  end
    # 绘制项目
    def draw_item(index)
    skill = @data[index]
    if skill
      rect = item_rect(index)
      rect.width -= 4
      draw_item_name(skill, rect.x, rect.y, enable?(skill))
      draw_skill_cost(rect, skill)
    end
  end
    # 绘制技能的使用消耗
    def draw_skill_cost(rect, skill)
    if @actor.skill_tp_cost(skill) > 0
      change_color(tp_cost_color, enable?(skill))
      draw_text(rect, @actor.skill_tp_cost(skill), 2)
    elsif @actor.skill_mp_cost(skill) > 0
      change_color(mp_cost_color, enable?(skill))
      draw_text(rect, @actor.skill_mp_cost(skill), 2)
    end
  end
    # 更新帮助内容
    def update_help
    @help_window.set_item(item)
  end
    # 刷新
    def refresh
    make_item_list
    create_contents
    draw_all_items
  end
end
