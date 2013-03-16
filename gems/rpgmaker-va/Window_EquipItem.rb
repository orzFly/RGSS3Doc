#encoding:utf-8
# 装备画面中，显示可替换装备的窗口。
class Window_EquipItem < Window_ItemList
    # 定义实例变量
    attr_reader   :status_window            # 状态窗口
    # 初始化对象
    def initialize(x, y, width, height)
    super
    @actor = nil
    @slot_id = 0
  end
    # 设置角色
    def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
    self.oy = 0
  end
    # 设置装备栏 ID 
    def slot_id=(slot_id)
    return if @slot_id == slot_id
    @slot_id = slot_id
    refresh
    self.oy = 0
  end
    # 查询使用列表中是否含有此物品
    def include?(item)
    return true if item == nil
    return false unless item.is_a?(RPG::EquipItem)
    return false if @slot_id < 0
    return false if item.etype_id != @actor.equip_slots[@slot_id]
    return @actor.equippable?(item)
  end
    # 查询此文件是否可以装备
    def enable?(item)
    return true
  end
    # 返回上一个选择的位置
    def select_last
  end
    # 设置状态窗口
    def status_window=(status_window)
    @status_window = status_window
    call_update_help
  end
    # 更新帮助内容
    def update_help
    super
    if @actor && @status_window
      temp_actor = Marshal.load(Marshal.dump(@actor))
      temp_actor.force_change_equip(@slot_id, item)
      @status_window.set_temp_actor(temp_actor)
    end
  end
end
