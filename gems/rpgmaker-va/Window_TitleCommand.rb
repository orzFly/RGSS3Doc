#encoding:utf-8
# 标题画面中，选择“开始游戏／继续游戏”的窗口。
class Window_TitleCommand < Window_Command
    # 初始化对象
    def initialize
    super(0, 0)
    update_placement
    select_symbol(:continue) if continue_enabled
    self.openness = 0
    open
  end
    # 获取窗口的宽度
    def window_width
    return 160
  end
    # 更新窗口的位置
    def update_placement
    self.x = (Graphics.width - width) / 2
    self.y = (Graphics.height * 1.6 - height) / 2
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::new_game, :new_game)
    add_command(Vocab::continue, :continue, continue_enabled)
    add_command(Vocab::shutdown, :shutdown)
  end
    # 获取“继续游戏”选项是否有效
    def continue_enabled
    DataManager.save_file_exists?
  end
end
