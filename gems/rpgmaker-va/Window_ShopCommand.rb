#encoding:utf-8
# 商店画面中，选择买入／卖出的窗口。
class Window_ShopCommand < Window_HorzCommand
    # 初始化对象
    def initialize(window_width, purchase_only)
    @window_width = window_width
    @purchase_only = purchase_only
    super(0, 0)
  end
    # 获取窗口的宽度
    def window_width
    @window_width
  end
    # 获取列数
    def col_max
    return 3
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::ShopBuy,    :buy)
    add_command(Vocab::ShopSell,   :sell,   !@purchase_only)
    add_command(Vocab::ShopCancel, :cancel)
  end
end
