#encoding:utf-8
# 技能画面中，显示技能使用者状态的窗口。
class Window_SkillStatus < Window_Base
    # 初始化对象
    def initialize(x, y)
    super(x, y, window_width, fitting_height(4))
    @actor = nil
  end
    # 获取窗口的宽度
    def window_width
    Graphics.width - 160
  end
    # 设置角色
    def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
  end
    # 刷新
    def refresh
    contents.clear
    return unless @actor
    draw_actor_face(@actor, 0, 0)
    draw_actor_simple_status(@actor, 108, line_height / 2)
  end
end
