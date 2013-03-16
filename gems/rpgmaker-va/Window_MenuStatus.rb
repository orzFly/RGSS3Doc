#encoding:utf-8
# 菜单画面中，显示队伍成员状态的窗口
class Window_MenuStatus < Window_Selectable
    # 定义实例变量
    attr_reader   :pending_index            # 保留位置（整队用）
    # 初始化对象
    def initialize(x, y)
    super(x, y, window_width, window_height)
    @pending_index = -1
    refresh
  end
    # 获取窗口的宽度
    def window_width
    Graphics.width - 160
  end
    # 获取窗口的高度
    def window_height
    Graphics.height
  end
    # 获取项目数
    def item_max
    $game_party.members.size
  end
    # 获取项目的高度
    def item_height
    (height - standard_padding * 2) / 4
  end
    # 绘制项目
    def draw_item(index)
    actor = $game_party.members[index]
    enabled = $game_party.battle_members.include?(actor)
    rect = item_rect(index)
    draw_item_background(index)
    draw_actor_face(actor, rect.x + 1, rect.y + 1, enabled)
    draw_actor_simple_status(actor, rect.x + 108, rect.y + line_height / 2)
  end
    # 绘制项目的背景
    def draw_item_background(index)
    if index == @pending_index
      contents.fill_rect(item_rect(index), pending_color)
    end
  end
    # 按下确定键时的处理
    def process_ok
    super
    $game_party.menu_actor = $game_party.members[index]
  end
    # 返回上一个选择的位置
    def select_last
    select($game_party.menu_actor.index || 0)
  end
    # 设置保留位置（整队用）
    def pending_index=(index)
    last_pending_index = @pending_index
    @pending_index = index
    redraw_item(@pending_index)
    redraw_item(last_pending_index)
  end
end
