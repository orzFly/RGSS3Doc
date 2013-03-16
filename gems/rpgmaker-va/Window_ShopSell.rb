#encoding:utf-8
# 商店画面中，卖出时显示持有物品的窗口。
class Window_ShopSell < Window_ItemList
    # 初始化对象
    def initialize(x, y, width, height)
    super(x, y, width, height)
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    enable?(@data[index])
  end
    # 查询物品是否可卖
    def enable?(item)
    item && item.price > 0
  end
end
