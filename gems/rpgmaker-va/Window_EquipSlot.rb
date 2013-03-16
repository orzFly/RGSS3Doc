#encoding:utf-8
# 装备画面中，显示角色当前装备的窗口。
class Window_EquipSlot < Window_Selectable
    # 定义实例变量
    attr_reader   :status_window            # 状态窗口
  attr_reader   :item_window              # 物品窗口
    # 初始化对象
    def initialize(x, y, width)
    super(x, y, width, window_height)
    @actor = nil
    refresh
  end
    # 获取窗口的高度
    def window_height
    fitting_height(visible_line_number)
  end
    # 获取显示行数
    def visible_line_number
    return 5
  end
    # 设置角色
    def actor=(actor)
    return if @actor == actor
    @actor = actor
    refresh
  end
    # 更新画面
    def update
    super
    @item_window.slot_id = index if @item_window
  end
    # 获取项目数
    def item_max
    @actor ? @actor.equip_slots.size : 0
  end
    # 获取物品
    def item
    @actor ? @actor.equips[index] : nil
  end
    # 绘制项目
    def draw_item(index)
    return unless @actor
    rect = item_rect_for_text(index)
    change_color(system_color, enable?(index))
    draw_text(rect.x, rect.y, 92, line_height, slot_name(index))
    draw_item_name(@actor.equips[index], rect.x + 92, rect.y, enable?(index))
  end
    # 获取装备栏的名字
    def slot_name(index)
    @actor ? Vocab::etype(@actor.equip_slots[index]) : ""
  end
    # 查询这个装备栏的装备是否可以替换
    def enable?(index)
    @actor ? @actor.equip_change_ok?(index) : false
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    enable?(index)
  end
    # 设置状态窗口
    def status_window=(status_window)
    @status_window = status_window
    call_update_help
  end
    # 设置物品窗口
    def item_window=(item_window)
    @item_window = item_window
    update
  end
    # 更新帮助内容
    def update_help
    super
    @help_window.set_item(item) if @help_window
    @status_window.set_temp_actor(nil) if @status_window
  end
end
