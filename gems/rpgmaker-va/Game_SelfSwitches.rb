#encoding:utf-8
# 处理独立开关的类。本质上是套了个壳的 Hash 。
# 本类的实例请参考 $game_self_switches 。
class Game_SelfSwitches
    # 初始化对象
    def initialize
    @data = {}
  end
    # 获取独立开关
    def [](key)
    @data[key] == true
  end
    # 设置独立开关
  # value : 开启 (true) / 关闭 (false)
    def []=(key, value)
    @data[key] = value
    on_change
  end
    # 设置独立开关时的处理
    def on_change
    $game_map.need_refresh = true
  end
end
