#encoding:utf-8
# 商店画面中，买入时显示所有商品的窗口。
class Window_ShopBuy < Window_Selectable
    # 定义实例变量
    attr_reader   :status_window            # 状态窗口
    # 初始化对象
    def initialize(x, y, height, shop_goods)
    super(x, y, window_width, height)
    @shop_goods = shop_goods
    @money = 0
    refresh
    select(0)
  end
    # 获取窗口的宽度
    def window_width
    return 304
  end
    # 获取项目数
    def item_max
    @data ? @data.size : 1
  end
    # 获取商品
    def item
    @data[index]
  end
    # 设置持有金钱
    def money=(money)
    @money = money
    refresh
  end
    # 获取选择项目的有效状态
    def current_item_enabled?
    enable?(@data[index])
  end
    # 获取商品价格
    def price(item)
    @price[item]
  end
    # 查询商品是否可买
    def enable?(item)
    item && price(item) <= @money && !$game_party.item_max?(item)
  end
    # 刷新
    def refresh
    make_item_list
    create_contents
    draw_all_items
  end
    # 生成商品列表
    def make_item_list
    @data = []
    @price = {}
    @shop_goods.each do |goods|
      case goods[0]
      when 0;  item = $data_items[goods[1]]
      when 1;  item = $data_weapons[goods[1]]
      when 2;  item = $data_armors[goods[1]]
      end
      if item
        @data.push(item)
        @price[item] = goods[2] == 0 ? item.price : goods[3]
      end
    end
  end
    # 绘制项目
    def draw_item(index)
    item = @data[index]
    rect = item_rect(index)
    draw_item_name(item, rect.x, rect.y, enable?(item))
    rect.width -= 4
    draw_text(rect, price(item), 2)
  end
    # 设置状态窗口
    def status_window=(status_window)
    @status_window = status_window
    call_update_help
  end
    # 更新帮助内容
    def update_help
    @help_window.set_item(item) if @help_window
    @status_window.item = item if @status_window
  end
end
