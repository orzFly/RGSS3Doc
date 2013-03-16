#encoding:utf-8
# 战斗画面中，选择“敌人目标”的窗口。
class Window_BattleEnemy < Window_Selectable
    # 初始化对象
  # info_viewport : 信息显示用显示端口
    def initialize(info_viewport)
    super(0, info_viewport.rect.y, window_width, fitting_height(4))
    refresh
    self.visible = false
    @info_viewport = info_viewport
  end
    # 获取窗口的宽度
    def window_width
    Graphics.width - 128
  end
    # 获取列数
    def col_max
    return 2
  end
    # 获取项目数
    def item_max
    $game_troop.alive_members.size
  end
    # 获取敌人实例
    def enemy
    $game_troop.alive_members[@index]
  end
    # 绘制项目
    def draw_item(index)
    change_color(normal_color)
    name = $game_troop.alive_members[index].name
    draw_text(item_rect_for_text(index), name)
  end
    # 显示窗口
    def show
    if @info_viewport
      width_remain = Graphics.width - width
      self.x = width_remain
      @info_viewport.rect.width = width_remain
      select(0)
    end
    super
  end
    # 隐藏窗口
    def hide
    @info_viewport.rect.width = Graphics.width if @info_viewport
    super
  end
end
