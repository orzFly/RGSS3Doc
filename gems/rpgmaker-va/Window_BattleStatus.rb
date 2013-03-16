#encoding:utf-8
# 战斗画面中，显示“队伍成员状态”的窗口。
class Window_BattleStatus < Window_Selectable
    # 初始化对象
    def initialize
    super(0, 0, window_width, window_height)
    refresh
    self.openness = 0
  end
    # 获取窗口的宽度
    def window_width
    Graphics.width - 128
  end
    # 获取窗口的高度
    def window_height
    fitting_height(visible_line_number)
  end
    # 获取显示行数
    def visible_line_number
    return 4
  end
    # 获取项目数
    def item_max
    $game_party.battle_members.size
  end
    # 刷新
    def refresh
    contents.clear
    draw_all_items
  end
    # 绘制项目
    def draw_item(index)
    actor = $game_party.battle_members[index]
    draw_basic_area(basic_area_rect(index), actor)
    draw_gauge_area(gauge_area_rect(index), actor)
  end
    # 获取基本区域的矩形
    def basic_area_rect(index)
    rect = item_rect_for_text(index)
    rect.width -= gauge_area_width + 10
    rect
  end
    # 获取值槽区域的矩形
    def gauge_area_rect(index)
    rect = item_rect_for_text(index)
    rect.x += rect.width - gauge_area_width
    rect.width = gauge_area_width
    rect
  end
    # 获取值槽区域的宽度
    def gauge_area_width
    return 220
  end
    # 绘制基本区域
    def draw_basic_area(rect, actor)
    draw_actor_name(actor, rect.x + 0, rect.y, 100)
    draw_actor_icons(actor, rect.x + 104, rect.y, rect.width - 104)
  end
    # 绘制值槽区域
    def draw_gauge_area(rect, actor)
    if $data_system.opt_display_tp
      draw_gauge_area_with_tp(rect, actor)
    else
      draw_gauge_area_without_tp(rect, actor)
    end
  end
    # 绘制值槽区域（包括 TP）
    def draw_gauge_area_with_tp(rect, actor)
    draw_actor_hp(actor, rect.x + 0, rect.y, 72)
    draw_actor_mp(actor, rect.x + 82, rect.y, 64)
    draw_actor_tp(actor, rect.x + 156, rect.y, 64)
  end
    # 绘制值槽区域（不包括 TP）
    def draw_gauge_area_without_tp(rect, actor)
    draw_actor_hp(actor, rect.x + 0, rect.y, 134)
    draw_actor_mp(actor, rect.x + 144,  rect.y, 76)
  end
end
