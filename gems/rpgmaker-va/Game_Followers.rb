#encoding:utf-8
# 包装跟随角色的数组的外壳。本类在 Game_Player 类的内部使用。
class Game_Followers
    # 定义实例变量
    attr_accessor :visible                  # 可视状态 (true 则开启人物跟随)
    # 初始化对象
  # leader : 带队的角色
    def initialize(leader)
    @visible = $data_system.opt_followers
    @gathering = false                    # 集合处理中的标志
    @data = []
    @data.push(Game_Follower.new(1, leader))
    (2...$game_party.max_battle_members).each do |index|
      @data.push(Game_Follower.new(index, @data[-1]))
    end
  end
    # 获取跟随角色
    def [](index)
    @data[index]
  end
    # 迭代
    def each
    @data.each {|follower| yield follower } if block_given?
  end
    # 迭代（逆向）
    def reverse_each
    @data.reverse.each {|follower| yield follower } if block_given?
  end
    # 刷新
    def refresh
    each {|follower| follower.refresh }
  end
    # 更新画面
    def update
    if gathering?
      move unless moving? || moving?
      @gathering = false if gather?
    end
    each {|follower| follower.update }
  end
    # 移动
    def move
    reverse_each {|follower| follower.chase_preceding_character }
  end
    # 同步
    def synchronize(x, y, d)
    each do |follower|
      follower.moveto(x, y)
      follower.set_direction(d)
    end
  end
    # 集合
    def gather
    @gathering = true
  end
    # 判定是否集合当中
    def gathering?
    @gathering
  end
    # 获取显示中的跟随角色的数组
    def visible_folloers
    @data.select {|follower| follower.visible? }
  end
    # 判定是否移动中
    def moving?
    visible_folloers.any? {|follower| follower.moving? }
  end
    # 判定是否集合完毕
    def gather?
    visible_folloers.all? {|follower| follower.gather? }
  end
    # 碰撞的判定
    def collide?(x, y)
    visible_folloers.any? {|follower| follower.pos?(x, y) }
  end
end
