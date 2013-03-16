#encoding:utf-8
# 商店画面中，输入“物品买入／卖出数量”的窗口。
class Window_ShopNumber < Window_Selectable
    # 定义实例变量
    attr_reader   :number                   # 数量
    # 初始化对象
    def initialize(x, y, height)
    super(x, y, window_width, height)
    @item = nil
    @max = 1
    @price = 0
    @number = 1
    @currency_unit = Vocab::currency_unit
  end
    # 获取窗口的宽度
    def window_width
    return 304
  end
    # 设置物品、最大值、价格、货币单位
    def set(item, max, price, currency_unit = nil)
    @item = item
    @max = max
    @price = price
    @currency_unit = currency_unit if currency_unit
    @number = 1
    refresh
  end
    # 设置货币单位
    def currency_unit=(currency_unit)
    @currency_unit = currency_unit
    refresh
  end
    # 刷新
    def refresh
    contents.clear
    draw_item_name(@item, 0, item_y)
    draw_number
    draw_total_price
  end
    # 绘制数量
    def draw_number
    change_color(normal_color)
    draw_text(cursor_x - 28, item_y, 22, line_height, "×")
    draw_text(cursor_x, item_y, cursor_width - 4, line_height, @number, 2)
  end
    # 绘制总价
    def draw_total_price
    width = contents_width - 8
    draw_currency_value(@price * @number, @currency_unit, 4, price_y, width)
  end
    # 显示物品名称行的 Y 坐标
    def item_y
    contents_height / 2 - line_height * 3 / 2
  end
    # 显示价格行的 Y 坐标
    def price_y
    contents_height / 2 + line_height / 2
  end
    # 获取光标的宽度
    def cursor_width
    figures * 10 + 12
  end
    # 获取光标的 X 坐标
    def cursor_x
    contents_width - cursor_width - 4
  end
    # 获取数量显示的最大列数
    def figures
    return 2
  end
    # 更新画面
    def update
    super
    if active
      last_number = @number
      update_number
      if @number != last_number
        Sound.play_cursor
        refresh
      end
    end
  end
    # 更新数量
    def update_number
    change_number(1)   if Input.repeat?(:RIGHT)
    change_number(-1)  if Input.repeat?(:LEFT)
    change_number(10)  if Input.repeat?(:UP)
    change_number(-10) if Input.repeat?(:DOWN)
  end
    # 更改数量
    def change_number(amount)
    @number = [[@number + amount, @max].min, 1].max
  end
    # 更新光标
    def update_cursor
    cursor_rect.set(cursor_x, item_y, cursor_width, line_height)
  end
end
