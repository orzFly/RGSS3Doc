#encoding:utf-8
# 游戏中所有 Scene 类（场景类）的父类
class Scene_Base
    # 主逻辑
    def main
    start
    post_start
    update until scene_changing?
    pre_terminate
    terminate
  end
    # 开始处理
    def start
    create_main_viewport
  end
    # 开始后处理
    def post_start
    perform_transition
    Input.update
  end
    # 判定是否更改场景中
    def scene_changing?
    SceneManager.scene != self
  end
    # 更新画面
    def update
    update_basic
  end
    # 更新画面（基础）
    def update_basic
    Graphics.update
    Input.update
    update_all_windows
  end
    # 结束前处理
    def pre_terminate
  end
    # 结束处理
    def terminate
    Graphics.freeze
    dispose_all_windows
    dispose_main_viewport
  end
    # 执行渐变
    def perform_transition
    Graphics.transition(transition_speed)
  end
    # 获取渐变速度
    def transition_speed
    return 10
  end
    # 生成显示端口
    def create_main_viewport
    @viewport = Viewport.new
    @viewport.z = 200
  end
    # 释放显示端口
    def dispose_main_viewport
    @viewport.dispose
  end
    # 更新所有窗口
    def update_all_windows
    instance_variables.each do |varname|
      ivar = instance_variable_get(varname)
      ivar.update if ivar.is_a?(Window)
    end
  end
    # 释放所有窗口
    def dispose_all_windows
    instance_variables.each do |varname|
      ivar = instance_variable_get(varname)
      ivar.dispose if ivar.is_a?(Window)
    end
  end
    # 返回前一个场景
    def return_scene
    SceneManager.return
  end
    # 淡出各种音效以及图像
    def fadeout_all(time = 1000)
    RPG::BGM.fade(time)
    RPG::BGS.fade(time)
    RPG::ME.fade(time)
    Graphics.fadeout(time * Graphics.frame_rate / 1000)
    RPG::BGM.stop
    RPG::BGS.stop
    RPG::ME.stop
  end
    # 游戏结束的判定
  # 如果全灭则切换到游戏结束画面。
    def check_gameover
    SceneManager.goto(Scene_Gameover) if $game_party.all_dead?
  end
end
