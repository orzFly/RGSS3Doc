#encoding:utf-8
# 结束游戏画面
class Scene_End < Scene_MenuBase
    # 开始处理
    def start
    super
    create_command_window
  end
    # 结束前处理
    def pre_terminate
    super
    close_command_window
  end
    # 生成背景
    def create_background
    super
    @background_sprite.tone.set(0, 0, 0, 128)
  end
    # 生成指令窗口
    def create_command_window
    @command_window = Window_GameEnd.new
    @command_window.set_handler(:to_title, method(:command_to_title))
    @command_window.set_handler(:shutdown, method(:command_shutdown))
    @command_window.set_handler(:cancel,   method(:return_scene))
  end
    # 关闭指令窗口
    def close_command_window
    @command_window.close
    update until @command_window.close?
  end
    # 指令“返回标题”
    def command_to_title
    close_command_window
    fadeout_all
    SceneManager.goto(Scene_Title)
  end
    # 指令“退出”
    def command_shutdown
    close_command_window
    fadeout_all
    SceneManager.exit
  end
end
