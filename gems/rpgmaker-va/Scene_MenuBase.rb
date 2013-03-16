#encoding:utf-8
# 所有菜单画面的基本处理
class Scene_MenuBase < Scene_Base
    # 开始处理
    def start
    super
    create_background
    @actor = $game_party.menu_actor
  end
    # 结束处理
    def terminate
    super
    dispose_background
  end
    # 生成背景
    def create_background
    @background_sprite = Sprite.new
    @background_sprite.bitmap = SceneManager.background_bitmap
    @background_sprite.color.set(16, 16, 16, 128)
  end
    # 释放背景
    def dispose_background
    @background_sprite.dispose
  end
    # 生成帮助窗口
    def create_help_window
    @help_window = Window_Help.new
    @help_window.viewport = @viewport
  end
    # 切换到下一个角色
    def next_actor
    @actor = $game_party.menu_actor_next
    on_actor_change
  end
    # 切换到上一个角色
    def prev_actor
    @actor = $game_party.menu_actor_prev
    on_actor_change
  end
    # 切换角色
    def on_actor_change
  end
end
