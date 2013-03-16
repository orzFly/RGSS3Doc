#encoding:utf-8
# 显示持有金钱的窗口
class Window_Gold < Window_Base
    # 初始化对象
    def initialize
    super(0, 0, window_width, fitting_height(1))
    refresh
  end
    # 获取窗口的宽度
    def window_width
    return 160
  end
    # 刷新
    def refresh
    contents.clear
    draw_currency_value(value, currency_unit, 4, 0, contents.width - 8)
  end
    # 获取持有金钱
    def value
    $game_party.gold
  end
    # 获取货币单位
    def currency_unit
    Vocab::currency_unit
  end
    # 打开窗口
    def open
    refresh
    super
  end
end
