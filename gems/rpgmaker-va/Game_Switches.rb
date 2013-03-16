#encoding:utf-8
# 处理开关的类。本质上是套了个壳的 Array 。本类的实例请参考 $game_switches 。
class Game_Switches
    # 初始化对象
    def initialize
    @data = []
  end
    # 获取开关
    def [](switch_id)
    @data[switch_id] || false
  end
    # 设置开关
  # value : 开启 (true) / 关闭 (false)
    def []=(switch_id, value)
    @data[switch_id] = value
    on_change
  end
    # 设置开关时的处理
    def on_change
    $game_map.need_refresh = true
  end
end
