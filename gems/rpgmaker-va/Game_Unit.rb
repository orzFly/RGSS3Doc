#encoding:utf-8
# 管理游戏单位的类。是 Game_Party 和 Game_Troop 类的父类。
class Game_Unit
    # 定义实例变量
    attr_reader   :in_battle                # 战斗中的标志
    # 初始化对象
    def initialize
    @in_battle = false
  end
    # 获取成员
    def members
    return []
  end
    # 获取存活的成员数组
    def alive_members
    members.select {|member| member.alive? }
  end
    # 获取死亡的成员数组
    def dead_members
    members.select {|member| member.dead? }
  end
    # 获取可以行动的成员数组
    def movable_members
    members.select {|member| member.movable? }
  end
    # 清除全员的战斗行为
    def clear_actions
    members.each {|member| member.clear_actions }
  end
    # 计算敏捷值的平均值
    def agi
    return 1 if members.size == 0
    members.inject(0) {|r, member| r += member.agi } / members.size
  end
    # 计算受到攻击的几率的总数
    def tgr_sum
    alive_members.inject(0) {|r, member| r + member.tgr }
  end
    # 随机决定目标
    def random_target
    tgr_rand = rand * tgr_sum
    alive_members.each do |member|
      tgr_rand -= member.tgr
      return member if tgr_rand < 0
    end
    alive_members[0]
  end
    # 随机决定目标（无法战斗）
    def random_dead_target
    dead_members.empty? ? nil : dead_members[rand(dead_members.size)]
  end
    # 决定顺带目标
  # 也就是如果上下目标无效，则获取下一个目标
    def smooth_target(index)
    member = members[index]
    (member && member.alive?) ? member : alive_members[0]
  end
    # 决定顺带目标（无法战斗）
    def smooth_dead_target(index)
    member = members[index]
    (member && member.dead?) ? member : dead_members[0]
  end
    # 清除行动结果
    def clear_results
    members.select {|member| member.result.clear }
  end
    # 战斗开始处理
    def on_battle_start
    members.each {|member| member.on_battle_start }
    @in_battle = true
  end
    # 战斗结束处理
    def on_battle_end
    @in_battle = false
    members.each {|member| member.on_battle_end }
  end
    # 生成战斗行动
    def make_actions
    members.each {|member| member.make_actions }
  end
    # 判定是否全灭
    def all_dead?
    alive_members.empty?
  end
    # 获取保护弱者的战斗者
    def substitute_battler
    members.find {|member| member.substitute? }
  end
end
