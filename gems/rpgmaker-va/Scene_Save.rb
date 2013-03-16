#encoding:utf-8
# 存档画面
class Scene_Save < Scene_File
    # 获取帮助窗口的文本
    def help_window_text
    Vocab::SaveMessage
  end
    # 获取开始时文件索引的位置
    def first_savefile_index
    DataManager.last_savefile_index
  end
    # 确定存档文件
    def on_savefile_ok
    super
    if DataManager.save_game(@index)
      on_save_success
    else
      Sound.play_buzzer
    end
  end
    # 存档成功时的处理
    def on_save_success
    Sound.play_save
    return_scene
  end
end
