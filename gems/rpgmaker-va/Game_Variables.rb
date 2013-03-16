#encoding:utf-8
# 处理变量的类。本质上是套了个壳的 Array 。本类的实例请参考 $game_variables 。
class Game_Variables
    # 初始化对象
    def initialize
    @data = []
  end
    # 获取变量
    def [](variable_id)
    @data[variable_id] || 0
  end
    # 设置变量
    def []=(variable_id, value)
    @data[variable_id] = value
    on_change
  end
    # 设置变量时的处理
    def on_change
    $game_map.need_refresh = true
  end
end
