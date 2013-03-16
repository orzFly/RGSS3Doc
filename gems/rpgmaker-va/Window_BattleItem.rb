#encoding:utf-8
# 战斗画面中，选择“使用物品”的窗口。
class Window_BattleItem < Window_ItemList
    # 初始化对象
  # info_viewport : 信息显示用的显示端口
    def initialize(help_window, info_viewport)
    y = help_window.height
    super(0, y, Graphics.width, info_viewport.rect.y - y)
    self.visible = false
    @help_window = help_window
    @info_viewport = info_viewport
  end
    # 查询使用列表中是否含有此物品
    def include?(item)
    $game_party.usable?(item)
  end
    # 显示窗口
    def show
    select_last
    @help_window.show
    super
  end
    # 隐藏窗口
    def hide
    @help_window.hide
    super
  end
end
