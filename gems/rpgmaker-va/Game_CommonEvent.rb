#encoding:utf-8
# 管理公共事件的类。拥有执行并行事件的功能。
# 本类在 Game_Map 类 ($game_map) 的内部使用。
class Game_CommonEvent
    # 初始化对象
    def initialize(common_event_id)
    @event = $data_common_events[common_event_id]
    refresh
  end
    # 刷新
    def refresh
    if active?
      @interpreter ||= Game_Interpreter.new
    else
      @interpreter = nil
    end
  end
    # 有效状态判定
    def active?
    @event.parallel? && $game_switches[@event.switch_id]
  end
    # 更新画面
    def update
    if @interpreter
      @interpreter.setup(@event.list) unless @interpreter.running?
      @interpreter.update
    end
  end
end
