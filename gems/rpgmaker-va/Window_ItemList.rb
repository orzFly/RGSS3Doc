#encoding:utf-8
# 物品画面中，显示持有物品的窗口。
class Window_ItemList < Window_Selectable
    # 初始化对象
    def initialize(x, y, width, height)
    super
    @category = :none
    @data = []
  end
    # 设置分类
    def category=(category)
    return if @category == category
    @category = category
    refresh
    self.oy = 0
  end
    # 获取列数
    def col_max
    return 2
  end
    # 获取项目数
    def item_max
    @data ? @data.size : 1
  end
    # 获取物品
    def item
    @data && index >= 0 ? @data[index] : nil
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    enable?(@data[index])
  end
    # 查询列表中是否含有此物品
    def include?(item)
    case @category
    when :item
      item.is_a?(RPG::Item) && !item.key_item?
    when :weapon
      item.is_a?(RPG::Weapon)
    when :armor
      item.is_a?(RPG::Armor)
    when :key_item
      item.is_a?(RPG::Item) && item.key_item?
    else
      false
    end
  end
    # 查询此物品是否可用
    def enable?(item)
    $game_party.usable?(item)
  end
    # 生成物品列表
    def make_item_list
    @data = $game_party.all_items.select {|item| include?(item) }
    @data.push(nil) if include?(nil)
  end
    # 返回上一个选择的位置
    def select_last
    select(@data.index($game_party.last_item.object) || 0)
  end
    # 绘制项目
    def draw_item(index)
    item = @data[index]
    if item
      rect = item_rect(index)
      rect.width -= 4
      draw_item_name(item, rect.x, rect.y, enable?(item))
      draw_item_number(rect, item)
    end
  end
    # 绘制物品个数
    def draw_item_number(rect, item)
    draw_text(rect, sprintf(":%2d", $game_party.item_number(item)), 2)
  end
    # 更新帮助内容
    def update_help
    @help_window.set_item(item)
  end
    # 刷新
    def refresh
    make_item_list
    create_contents
    draw_all_items
  end
end
