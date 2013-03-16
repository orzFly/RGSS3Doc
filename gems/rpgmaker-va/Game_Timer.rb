#encoding:utf-8
# 计时器。本类的实例请参考 $game_timer 。
class Game_Timer
    # 初始化对象
    def initialize
    @count = 0
    @working = false
  end
    # 更新画面
    def update
    if @working && @count > 0
      @count -= 1
      on_expire if @count == 0
    end
  end
    # 开始
    def start(count)
    @count = count
    @working = true
  end
    # 停止
    def stop
    @working = false
  end
    # 判定是否正在工作
    def working?
    @working
  end
    # 获取秒数
    def sec
    @count / Graphics.frame_rate
  end
    # 计时器为 0 时的处理
    def on_expire
    BattleManager.abort
  end
end
