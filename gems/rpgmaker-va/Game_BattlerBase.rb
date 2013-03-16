#encoding:utf-8
# 管理战斗者的类。主要含有能力值计算的方法。Game_Battler 类的父类。
class Game_BattlerBase
    # 常量（特性）
    FEATURE_ELEMENT_RATE  = 11              # 属性抗性
  FEATURE_DEBUFF_RATE   = 12              # 弱化抗性
  FEATURE_STATE_RATE    = 13              # 状态抗性
  FEATURE_STATE_RESIST  = 14              # 状态免疫
  FEATURE_PARAM         = 21              # 普通能力
  FEATURE_XPARAM        = 22              # 添加能力
  FEATURE_SPARAM        = 23              # 特殊能力
  FEATURE_ATK_ELEMENT   = 31              # 攻击附带属性
  FEATURE_ATK_STATE     = 32              # 攻击附带状态
  FEATURE_ATK_SPEED     = 33              # 修正攻击速度
  FEATURE_ATK_TIMES     = 34              # 添加攻击次数
  FEATURE_STYPE_ADD     = 41              # 添加技能类型
  FEATURE_STYPE_SEAL    = 42              # 禁用技能类型
  FEATURE_SKILL_ADD     = 43              # 添加技能
  FEATURE_SKILL_SEAL    = 44              # 禁用技能
  FEATURE_EQUIP_WTYPE   = 51              # 可装备武器类型
  FEATURE_EQUIP_ATYPE   = 52              # 可装备护甲类型
  FEATURE_EQUIP_FIX     = 53              # 固定装备
  FEATURE_EQUIP_SEAL    = 54              # 禁用装备
  FEATURE_SLOT_TYPE     = 55              # 装备风格
  FEATURE_ACTION_PLUS   = 61              # 添加行动次数
  FEATURE_SPECIAL_FLAG  = 62              # 特殊标志
  FEATURE_COLLAPSE_TYPE = 63              # 消失效果
  FEATURE_PARTY_ABILITY = 64              # 队伍能力
    # 常量（特殊标志）
    FLAG_ID_AUTO_BATTLE   = 0               # 自动战斗
  FLAG_ID_GUARD         = 1               # 擅长防御
  FLAG_ID_SUBSTITUTE    = 2               # 保护弱者
  FLAG_ID_PRESERVE_TP   = 3               # 特技专注 
    # 常量（能力强化／弱化图标的起始编号）
    ICON_BUFF_START       = 64              # 强化（16 个）
  ICON_DEBUFF_START     = 80              # 弱化（16 个）
    # 定义实例变量
    attr_reader   :hp                       # HP
  attr_reader   :mp                       # MP
  attr_reader   :tp                       # TP
    # 各种能力值的简易访问方法
    def mhp;  param(0);   end    # 最大HP          Maximum Hit Point
  def mmp;  param(1);   end    # 最大MP          Maximum Magic Point
  def atk;  param(2);   end    # 物理攻击        ATtacK power
  def def;  param(3);   end    # 物理防御        DEFense power
  def mat;  param(4);   end    # 魔法攻击        Magic ATtack power
  def mdf;  param(5);   end    # 魔法防御        Magic DeFense power
  def agi;  param(6);   end    # 敏 捷 值        AGIlity
  def luk;  param(7);   end    # 幸 运 值        LUcK
  def hit;  xparam(0);  end    # 成功几率        HIT rate
  def eva;  xparam(1);  end    # 闪避几率        EVAsion rate
  def cri;  xparam(2);  end    # 必杀几率        CRItical rate
  def cev;  xparam(3);  end    # 闪避必杀几率    Critical EVasion rate
  def mev;  xparam(4);  end    # 闪避魔法几率    Magic EVasion rate
  def mrf;  xparam(5);  end    # 反射魔法几率    Magic ReFlection rate
  def cnt;  xparam(6);  end    # 反击几率        CouNTer attack rate
  def hrg;  xparam(7);  end    # HP再生速度      Hp ReGeneration rate
  def mrg;  xparam(8);  end    # MP再生速度      Mp ReGeneration rate
  def trg;  xparam(9);  end    # TP再生速度      Tp ReGeneration rate
  def tgr;  sparam(0);  end    # 受到攻击的几率        TarGet Rate
  def grd;  sparam(1);  end    # 防御效果比率    GuaRD effect rate
  def rec;  sparam(2);  end    # 恢复效果比率    RECovery effect rate
  def pha;  sparam(3);  end    # 药理知识        PHArmacology
  def mcr;  sparam(4);  end    # MP消费率        Mp Cost Rate
  def tcr;  sparam(5);  end    # TP消耗率        Tp Charge Rate
  def pdr;  sparam(6);  end    # 物理伤害加成    Physical Damage Rate
  def mdr;  sparam(7);  end    # 魔法伤害加成    Magical Damage Rate
  def fdr;  sparam(8);  end    # 地形伤害加成    Floor Damage Rate
  def exr;  sparam(9);  end    # 经验获得加成    EXperience Rate
    # 初始化对象
    def initialize
    @hp = @mp = @tp = 0
    @hidden = false
    clear_param_plus
    clear_states
    clear_buffs
  end
    # 清除能力的增加值
    def clear_param_plus
    @param_plus = [0] * 8
  end
    # 清除状态信息
    def clear_states
    @states = []
    @state_turns = {}
    @state_steps = {}
  end
    # 消除状态
    def erase_state(state_id)
    @states.delete(state_id)
    @state_turns.delete(state_id)
    @state_steps.delete(state_id)
  end
    # 清除能力强化信息
    def clear_buffs
    @buffs = Array.new(8) { 0 }
    @buff_turns = {}
  end
    # 检査是否含有某状态
    def state?(state_id)
    @states.include?(state_id)
  end
    # 检査是否含有无法战斗状态
    def death_state?
    state?(death_state_id)
  end
    # 获取无法战斗的状态ID
    def death_state_id
    return 1
  end
    # 获取当前状态的实例数组
    def states
    @states.collect {|id| $data_states[id] }
  end
    # 获取当前状态的图标编号数组
    def state_icons
    icons = states.collect {|state| state.icon_index }
    icons.delete(0)
    icons
  end
    # 获取当前强化／弱化状态的图标编号数组
    def buff_icons
    icons = []
    @buffs.each_with_index {|lv, i| icons.push(buff_icon_index(lv, i)) }
    icons.delete(0)
    icons
  end
    # 获取强化／弱化状态的对应图标编号
    def buff_icon_index(buff_level, param_id)
    if buff_level > 0
      return ICON_BUFF_START + (buff_level - 1) * 8 + param_id
    elsif buff_level < 0
      return ICON_DEBUFF_START + (-buff_level - 1) * 8 + param_id 
    else
      return 0
    end
  end
    # 获取所有拥有特性的实例的数组
    def feature_objects
    states
  end
    # 获取所有特性实例的数组
    def all_features
    feature_objects.inject([]) {|r, obj| r + obj.features }
  end
    # 获取特性实例的数组（限定特性代码）
    def features(code)
    all_features.select {|ft| ft.code == code }
  end
    # 获取特性实例的数组（限定特性代码和数据ID）
    def features_with_id(code, id)
    all_features.select {|ft| ft.code == code && ft.data_id == id }
  end
    # 计算特性值的乘积
    def features_pi(code, id)
    features_with_id(code, id).inject(1.0) {|r, ft| r *= ft.value }
  end
    # 计算特性值的总和（指定数据ID）
    def features_sum(code, id)
    features_with_id(code, id).inject(0.0) {|r, ft| r += ft.value }
  end
    # 计算特性值的总和（不限定数据ID）
    def features_sum_all(code)
    features(code).inject(0.0) {|r, ft| r += ft.value }
  end
    # 特性的集合和计算
    def features_set(code)
    features(code).inject([]) {|r, ft| r |= [ft.data_id] }
  end
    # 获取普通能力的基础值
    def param_base(param_id)
    return 0
  end
    # 获取普通能力的附加值
    def param_plus(param_id)
    @param_plus[param_id]
  end
    # 获取普通能力的最小值
    def param_min(param_id)
    return 0 if param_id == 1  # MMP
    return 1
  end
    # 获取普通能力的最大值
    def param_max(param_id)
    return 999999 if param_id == 0  # MHP
    return 9999   if param_id == 1  # MMP
    return 999
  end
    # 获取普通能力的变化率
    def param_rate(param_id)
    features_pi(FEATURE_PARAM, param_id)
  end
    # 获取普通能力的强化／弱化变化率
    def param_buff_rate(param_id)
    @buffs[param_id] * 0.25 + 1.0
  end
    # 获取普通能力
    def param(param_id)
    value = param_base(param_id) + param_plus(param_id)
    value *= param_rate(param_id) * param_buff_rate(param_id)
    [[value, param_max(param_id)].min, param_min(param_id)].max.to_i
  end
    # 获取添加能力
    def xparam(xparam_id)
    features_sum(FEATURE_XPARAM, xparam_id)
  end
    # 获取特殊能力
    def sparam(sparam_id)
    features_pi(FEATURE_SPARAM, sparam_id)
  end
    # 获取属性抗性
    def element_rate(element_id)
    features_pi(FEATURE_ELEMENT_RATE, element_id)
  end
    # 获取弱化抗性
    def debuff_rate(param_id)
    features_pi(FEATURE_DEBUFF_RATE, param_id)
  end
    # 获取状态抗性
    def state_rate(state_id)
    features_pi(FEATURE_STATE_RATE, state_id)
  end
    # 获取免疫状态数组
    def state_resist_set
    features_set(FEATURE_STATE_RESIST)
  end
    # 判定状态是否免疫
    def state_resist?(state_id)
    state_resist_set.include?(state_id)
  end
    # 获取攻击附加属性
    def atk_elements
    features_set(FEATURE_ATK_ELEMENT)
  end
    # 获取攻击附加状态
    def atk_states
    features_set(FEATURE_ATK_STATE)
  end
    # 获取攻击附加状态的发动几率
    def atk_states_rate(state_id)
    features_sum(FEATURE_ATK_STATE, state_id)
  end
    # 获取修正攻击速度
    def atk_speed
    features_sum_all(FEATURE_ATK_SPEED)
  end
    # 获取添加攻击次数
    def atk_times_add
    [features_sum_all(FEATURE_ATK_TIMES), 0].max
  end
    # 获取添加技能类型
    def added_skill_types
    features_set(FEATURE_STYPE_ADD)
  end
    # 判定技能类型是否被禁用
    def skill_type_sealed?(stype_id)
    features_set(FEATURE_STYPE_SEAL).include?(stype_id)
  end
    # 获取添加的技能
    def added_skills
    features_set(FEATURE_SKILL_ADD)
  end
    # 判定技能是否被禁用
    def skill_sealed?(skill_id)
    features_set(FEATURE_SKILL_SEAL).include?(skill_id)
  end
    # 判定武器是否可以装备
    def equip_wtype_ok?(wtype_id)
    features_set(FEATURE_EQUIP_WTYPE).include?(wtype_id)
  end
    # 判定护甲是否可以装备
    def equip_atype_ok?(atype_id)
    features_set(FEATURE_EQUIP_ATYPE).include?(atype_id)
  end
    # 判定是否固定武器
    def equip_type_fixed?(etype_id)
    features_set(FEATURE_EQUIP_FIX).include?(etype_id)
  end
    # 判定装备是否被禁用
    def equip_type_sealed?(etype_id)
    features_set(FEATURE_EQUIP_SEAL).include?(etype_id)
  end
    # 获取装备风格
    def slot_type
    features_set(FEATURE_SLOT_TYPE).max || 0
  end
    # 判定是否双持武器
    def dual_wield?
    slot_type == 1
  end
    # 获取添加行动次数几率的数组
    def action_plus_set
    features(FEATURE_ACTION_PLUS).collect {|ft| ft.value }
  end
    # 判定特殊标志
    def special_flag(flag_id)
    features(FEATURE_SPECIAL_FLAG).any? {|ft| ft.data_id == flag_id }
  end
    # 获取消失效果
    def collapse_type
    features_set(FEATURE_COLLAPSE_TYPE).max || 0
  end
    # 判定队伍能力
    def party_ability(ability_id)
    features(FEATURE_PARTY_ABILITY).any? {|ft| ft.data_id == ability_id }
  end
    # 判定是否自动战斗
    def auto_battle?
    special_flag(FLAG_ID_AUTO_BATTLE)
  end
    # 判定是否擅长防御
    def guard?
    special_flag(FLAG_ID_GUARD) && movable?
  end
    # 判定是否保护弱者
    def substitute?
    special_flag(FLAG_ID_SUBSTITUTE) && movable?
  end
    # 判定是否特技专注
    def preserve_tp?
    special_flag(FLAG_ID_PRESERVE_TP)
  end
    # 添加能力
    def add_param(param_id, value)
    @param_plus[param_id] += value
    refresh
  end
    # 更改 HP 
    def hp=(hp)
    @hp = hp
    refresh
  end
    # 更改 MP 
    def mp=(mp)
    @mp = mp
    refresh
  end
    # 增减 HP （事件用）
  # value        : 数值
  # enable_death : 是否允许致死
    def change_hp(value, enable_death)
    if !enable_death && @hp + value <= 0
      self.hp = 1
    else
      self.hp += value
    end
  end
    # 更改 TP 
    def tp=(tp)
    @tp = [[tp, max_tp].min, 0].max
  end
    # 获取 TP 的最大值
    def max_tp
    return 100
  end
    # 刷新
    def refresh
    state_resist_set.each {|state_id| erase_state(state_id) }
    @hp = [[@hp, mhp].min, 0].max
    @mp = [[@mp, mmp].min, 0].max
    @hp == 0 ? add_state(death_state_id) : remove_state(death_state_id)
  end
    # 完全恢复
    def recover_all
    clear_states
    @hp = mhp
    @mp = mmp
  end
    # 获取 HP 的比率
    def hp_rate
    @hp.to_f / mhp
  end
    # 获取 MP 的比率
    def mp_rate
    mmp > 0 ? @mp.to_f / mmp : 0
  end
    # 获取 TP 的比率
    def tp_rate
    @tp.to_f / 100
  end
    # 隐藏
    def hide
    @hidden = true
  end
    # 出现
    def appear
    @hidden = false
  end
    # 获取隐藏状态
    def hidden?
    @hidden
  end
    # 判定是否存在
    def exist?
    !hidden?
  end
    # 判定是否死亡
    def dead?
    exist? && death_state?
  end
    # 判定是否存活
    def alive?
    exist? && !death_state?
  end
    # 判定是否正常
    def normal?
    exist? && restriction == 0
  end
    # 判定是否可以输入指令
    def inputable?
    normal? && !auto_battle?
  end
    # 判定是否可以行动
    def movable?
    exist? && restriction < 4
  end
    # 判定是否处于混乱
    def confusion?
    exist? && restriction >= 1 && restriction <= 3
  end
    # 获取混乱等级
    def confusion_level
    confusion? ? restriction : 0
  end
    # 判定是否队友
    def actor?
    return false
  end
    # 判定是否敌人
    def enemy?
    return false
  end
    # 状态排序
  # 依照优先度排列数组 @states，高优先度显示的状态排在前面。
    def sort_states
    @states = @states.sort_by {|id| [-$data_states[id].priority, id] }
  end
    # 获取限制状态
  # 从当前附加的状态中获取限制最大的状态 
    def restriction
    states.collect {|state| state.restriction }.push(0).max
  end
    # 获取最重要的状态信息
    def most_important_state_text
    states.each {|state| return state.message3 unless state.message3.empty? }
    return ""
  end
    # 判定是否装备着使用此技能所需要装备武器
    def skill_wtype_ok?(skill)
    return true
  end
    # 计算技能消费的 MP 
    def skill_mp_cost(skill)
    (skill.mp_cost * mcr).to_i
  end
    # 计算技能消费的 TP 
    def skill_tp_cost(skill)
    skill.tp_cost
  end
    # 判定是否足够扣除技能的使用消耗
    def skill_cost_payable?(skill)
    tp >= skill_tp_cost(skill) && mp >= skill_mp_cost(skill)
  end
    # 扣除技能的使用消耗
    def pay_skill_cost(skill)
    self.mp -= skill_mp_cost(skill)
    self.tp -= skill_tp_cost(skill)
  end
    # 检查是否可以使用技能／物品
    def occasion_ok?(item)
    $game_party.in_battle ? item.battle_ok? : item.menu_ok?
  end
    # 检查技能／物品的使用条件（共通）
    def usable_item_conditions_met?(item)
    movable? && occasion_ok?(item)
  end
    # 检查技能的使用条件
    def skill_conditions_met?(skill)
    usable_item_conditions_met?(skill) &&
    skill_wtype_ok?(skill) && skill_cost_payable?(skill) &&
    !skill_sealed?(skill.id) && !skill_type_sealed?(skill.stype_id)
  end
    # 检查物品的使用条件
    def item_conditions_met?(item)
    usable_item_conditions_met?(item) && $game_party.has_item?(item)
  end
    # 判定技能／使用物品是否可用
    def usable?(item)
    return skill_conditions_met?(item) if item.is_a?(RPG::Skill)
    return item_conditions_met?(item)  if item.is_a?(RPG::Item)
    return false
  end
    # 判定物品是否可以装备
    def equippable?(item)
    return false unless item.is_a?(RPG::EquipItem)
    return false if equip_type_sealed?(item.etype_id)
    return equip_wtype_ok?(item.wtype_id) if item.is_a?(RPG::Weapon)
    return equip_atype_ok?(item.atype_id) if item.is_a?(RPG::Armor)
    return false
  end
    # 获取普通攻击的技能 ID
    def attack_skill_id
    return 1
  end
    # 获取防御的技能 ID
    def guard_skill_id
    return 2
  end
    # 判定是否能使用普通攻击
    def attack_usable?
    usable?($data_skills[attack_skill_id])
  end
    # 判定是否能进行防御
    def guard_usable?
    usable?($data_skills[guard_skill_id])
  end
end
