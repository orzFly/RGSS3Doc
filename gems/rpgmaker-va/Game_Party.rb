#encoding:utf-8
# 管理队伍的类。保存有金钱及物品的信息。本类的实例请参考 $game_party 。
class Game_Party < Game_Unit
    # 常量
    ABILITY_ENCOUNTER_HALF    = 0           # 遇敌几率减半
  ABILITY_ENCOUNTER_NONE    = 1           # 随机遇敌无效
  ABILITY_CANCEL_SURPRISE   = 2           # 敌人偷袭无效
  ABILITY_RAISE_PREEMPTIVE  = 3           # 先制攻击几率上升
  ABILITY_GOLD_DOUBLE       = 4           # 获得金钱数量双倍
  ABILITY_DROP_ITEM_DOUBLE  = 5           # 物品掉落几率双倍
    # 定义实例变量
    attr_reader   :gold                     # 持有金钱
  attr_reader   :steps                    # 步数
  attr_reader   :last_item                # 光标记忆用 : 物品
    # 初始化对象
    def initialize
    super
    @gold = 0
    @steps = 0
    @last_item = Game_BaseItem.new
    @menu_actor_id = 0
    @target_actor_id = 0
    @actors = []
    init_all_items
  end
    # 初始化所有物品列表
    def init_all_items
    @items = {}
    @weapons = {}
    @armors = {}
  end
    # 存在判定
    def exists
    !@actors.empty?
  end
    # 获取成员
    def members
    in_battle ? battle_members : all_members
  end
    # 获取所有成员
    def all_members
    @actors.collect {|id| $game_actors[id] }
  end
    # 获取参战角色
    def battle_members
    all_members[0, max_battle_members].select {|actor| actor.exist? }
  end
    # 获取参战角色的最大数
    def max_battle_members
    return 4
  end
    # 获取领队
    def leader
    battle_members[0]
  end
    # 获取物品实例的数组 
    def items
    @items.keys.sort.collect {|id| $data_items[id] }
  end
    # 获取武器实例的数组 
    def weapons
    @weapons.keys.sort.collect {|id| $data_weapons[id] }
  end
    # 获取护甲实例的数组 
    def armors
    @armors.keys.sort.collect {|id| $data_armors[id] }
  end
    # 获取所有装备实例的数组
    def equip_items
    weapons + armors
  end
    # 获取所有物品实例的数组
    def all_items
    items + equip_items
  end
    # 获取物品类对应的容器实例
    def item_container(item_class)
    return @items   if item_class == RPG::Item
    return @weapons if item_class == RPG::Weapon
    return @armors  if item_class == RPG::Armor
    return nil
  end
    # 设置初期队伍
    def setup_starting_members
    @actors = $data_system.party_members.clone
  end
    # 获取队伍名称
  # 只有一人时返回角色的名字，含有多人时返回“某某的队伍”。
    def name
    return ""           if battle_members.size == 0
    return leader.name  if battle_members.size == 1
    return sprintf(Vocab::PartyName, leader.name)
  end
    # 设置战斗测试
    def setup_battle_test
    setup_battle_test_members
    setup_battle_test_items
  end
    # 设置战斗测试用队伍
    def setup_battle_test_members
    $data_system.test_battlers.each do |battler|
      actor = $game_actors[battler.actor_id]
      actor.change_level(battler.level, false)
      actor.init_equips(battler.equips)
      actor.recover_all
      add_actor(actor.id)
    end
  end
    # 设置战斗测试用物品
    def setup_battle_test_items
    $data_items.each do |item|
      gain_item(item, max_item_number(item)) if item && !item.name.empty?
    end
  end
    # 获取队伍成员的最高等级
    def highest_level
    lv = members.collect {|actor| actor.level }.max
  end
    # 角色入队
    def add_actor(actor_id)
    @actors.push(actor_id) unless @actors.include?(actor_id)
    $game_player.refresh
    $game_map.need_refresh = true
  end
    # 角色离队
    def remove_actor(actor_id)
    @actors.delete(actor_id)
    $game_player.refresh
    $game_map.need_refresh = true
  end
    # 增加／减少持有金钱
    def gain_gold(amount)
    @gold = [[@gold + amount, 0].max, max_gold].min
  end
    # 减少持有金钱
    def lose_gold(amount)
    gain_gold(-amount)
  end
    # 获取持有金钱的最大值
    def max_gold
    return 99999999
  end
    # 增加步数
    def increase_steps
    @steps += 1
  end
    # 获取物品的持有数
    def item_number(item)
    container = item_container(item.class)
    container ? container[item.id] || 0 : 0
  end
    # 获取物品的最大持有数
    def max_item_number(item)
    return 99
  end
    # 判定物品是否达到最大持有数
    def item_max?(item)
    item_number(item) >= max_item_number(item)
  end
    # 判定是否持有某物品
  # include_equip : 检索是否包括装备
    def has_item?(item, include_equip = false)
    return true if item_number(item) > 0
    return include_equip ? members_equip_include?(item) : false
  end
    # 判定队伍成员是否装备着指定物品
    def members_equip_include?(item)
    members.any? {|actor| actor.equips.include?(item) }
  end
    # 增加／减少物品
  # include_equip : 是否包括装备
    def gain_item(item, amount, include_equip = false)
    container = item_container(item.class)
    return unless container
    last_number = item_number(item)
    new_number = last_number + amount
    container[item.id] = [[new_number, 0].max, max_item_number(item)].min
    container.delete(item.id) if container[item.id] == 0
    if include_equip && new_number < 0
      discard_members_equip(item, -new_number)
    end
    $game_map.need_refresh = true
  end
    # 丢弃成员的装备
    def discard_members_equip(item, amount)
    n = amount
    members.each do |actor|
      while n > 0 && actor.equips.include?(item)
        actor.discard_equip(item)
        n -= 1
      end
    end
  end
    # 减少物品
  # include_equip : 是否包括装备
    def lose_item(item, amount, include_equip = false)
    gain_item(item, -amount, include_equip)
  end
    # 消耗物品
  # 减少 1 个持有数。
    def consume_item(item)
    lose_item(item, 1) if item.is_a?(RPG::Item) && item.consumable
  end
    # 技能／使用物品可能判定
    def usable?(item)
    members.any? {|actor| actor.usable?(item) }
  end
    # 战斗时指令输入可能判定
    def inputable?
    members.any? {|actor| actor.inputable? }
  end
    # 判定是否全灭
    def all_dead?
    super && ($game_party.in_battle || members.size > 0)
  end
    # 角色移动一步时的处理
    def on_player_walk
    members.each {|actor| actor.on_player_walk }
  end
    # 获取菜单画面中选中角色
    def menu_actor
    $game_actors[@menu_actor_id] || members[0]
  end
    # 设置菜单画面中选中角色
    def menu_actor=(actor)
    @menu_actor_id = actor.id
  end
    # 菜单画面中，选择下一个角色
    def menu_actor_next
    index = members.index(menu_actor) || -1
    index = (index + 1) % members.size
    self.menu_actor = members[index]
  end
    # 菜单画面中，选择上一个角色
    def menu_actor_prev
    index = members.index(menu_actor) || 1
    index = (index + members.size - 1) % members.size
    self.menu_actor = members[index]
  end
    # 获取技能／使用物品目标
    def target_actor
    $game_actors[@target_actor_id] || members[0]
  end
    # 设置技能／使用物品目标
    def target_actor=(actor)
    @target_actor_id = actor.id
  end
    # 交换顺序
    def swap_order(index1, index2)
    @actors[index1], @actors[index2] = @actors[index2], @actors[index1]
    $game_player.refresh
  end
    # 存档文件显示用的角色图像信息
    def characters_for_savefile
    battle_members.collect do |actor|
      [actor.character_name, actor.character_index]
    end
  end
    # 判定队伍能力
    def party_ability(ability_id)
    battle_members.any? {|actor| actor.party_ability(ability_id) }
  end
    # 判定是否遇敌几率减半
    def encounter_half?
    party_ability(ABILITY_ENCOUNTER_HALF)
  end
    # 判定是否随机遇敌无效
    def encounter_none?
    party_ability(ABILITY_ENCOUNTER_NONE)
  end
    # 判定是否敌人偷袭无效
    def cancel_surprise?
    party_ability(ABILITY_CANCEL_SURPRISE)
  end
    # 判定是否先制攻击几率上升
    def raise_preemptive?
    party_ability(ABILITY_RAISE_PREEMPTIVE)
  end
    # 判定是否获得金钱数量双倍
    def gold_double?
    party_ability(ABILITY_GOLD_DOUBLE)
  end
    # 判定是否物品掉落几率双倍
    def drop_item_double?
    party_ability(ABILITY_DROP_ITEM_DOUBLE)
  end
    # 计算先制攻击几率
    def rate_preemptive(troop_agi)
    (agi >= troop_agi ? 0.05 : 0.03) * (raise_preemptive? ? 4 : 1)
  end
    # 计算敌人偷袭几率
    def rate_surprise(troop_agi)
    cancel_surprise? ? 0 : (agi >= troop_agi ? 0.03 : 0.05)
  end
end
