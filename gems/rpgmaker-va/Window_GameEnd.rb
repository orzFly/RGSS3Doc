#encoding:utf-8
# 游戏结束画面中，选择“返回标题／退出游戏”的窗口。
class Window_GameEnd < Window_Command
    # 初始化对象
    def initialize
    super(0, 0)
    update_placement
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
    self.y = (Graphics.height - height) / 2
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::to_title, :to_title)
    add_command(Vocab::shutdown, :shutdown)
    add_command(Vocab::cancel,   :cancel)
  end
end
