#encoding:utf-8
# 管理技能、物品、武器、护甲的统一类。会根据自己的所属类别而管理不同的数据。
class Game_BaseItem
    # 初始化对象
    def initialize
    @class = nil
    @item_id = 0
  end
    # 判定类
    def is_skill?;   @class == RPG::Skill;   end
  def is_item?;    @class == RPG::Item;    end
  def is_weapon?;  @class == RPG::Weapon;  end
  def is_armor?;   @class == RPG::Armor;   end
  def is_nil?;     @class == nil;          end
    # 获取物品实例
    def object
    return $data_skills[@item_id]  if is_skill?
    return $data_items[@item_id]   if is_item?
    return $data_weapons[@item_id] if is_weapon?
    return $data_armors[@item_id]  if is_armor?
    return nil
  end
    # 设置物品实例
    def object=(item)
    @class = item ? item.class : nil
    @item_id = item ? item.id : 0
  end
    # 设置装备的 ID
  # is_weapon : 是否武器
  # item_id   : 武器／护甲 ID
    def set_equip(is_weapon, item_id)
    @class = is_weapon ? RPG::Weapon : RPG::Armor
    @item_id = item_id
  end
end
