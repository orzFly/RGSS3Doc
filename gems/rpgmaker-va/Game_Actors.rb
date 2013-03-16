#encoding:utf-8
# 包装角色数组的外壳。本类的实例请参考 $game_actors 。
class Game_Actors
    # 初始化对象
    def initialize
    @data = []
  end
    # 获取角色
    def [](actor_id)
    return nil unless $data_actors[actor_id]
    @data[actor_id] ||= Game_Actor.new(actor_id)
  end
end
