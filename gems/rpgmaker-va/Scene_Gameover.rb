#encoding:utf-8
# 游戏结束画面
class Scene_Gameover < Scene_Base
    # 开始处理
    def start
    super
    play_gameover_music
    fadeout_frozen_graphics
    create_background
  end
    # 结束处理
    def terminate
    super
    dispose_background
  end
    # 更新画面
    def update
    super
    goto_title if Input.trigger?(:C)
  end
    # 执行渐变
    def perform_transition
    Graphics.transition(fadein_speed)
  end
    # 播放游戏结束画面的音乐
    def play_gameover_music
    RPG::BGM.stop
    RPG::BGS.stop
    $data_system.gameover_me.play
  end
    # 冻结画面并淡出
    def fadeout_frozen_graphics
    Graphics.transition(fadeout_speed)
    Graphics.freeze
  end
    # 生成背景
    def create_background
    @sprite = Sprite.new
    @sprite.bitmap = Cache.system("GameOver")
  end
    # 释放背景
    def dispose_background
    @sprite.bitmap.dispose
    @sprite.dispose
  end
    # 获取淡出速度
    def fadeout_speed
    return 60
  end
    # 获取淡入速度
    def fadein_speed
    return 120
  end
    # 切换到标题画面
    def goto_title
    fadeout_all
    SceneManager.goto(Scene_Title)
  end
end
