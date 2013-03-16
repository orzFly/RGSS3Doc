#encoding:utf-8
# 物品画面和商店画面中，显示装备、所持物品等项目列表的窗口。
class Window_ItemCategory < Window_HorzCommand
    # 定义实例变量
    attr_reader   :item_window
    # 初始化对象
    def initialize
    super(0, 0)
  end
    # 获取窗口的宽度
    def window_width
    Graphics.width
  end
    # 获取列数
    def col_max
    return 4
  end
    # 更新画面
    def update
    super
    @item_window.category = current_symbol if @item_window
  end
    # 生成指令列表
    def make_command_list
    add_command(Vocab::item,     :item)
    add_command(Vocab::weapon,   :weapon)
    add_command(Vocab::armor,    :armor)
    add_command(Vocab::key_item, :key_item)
  end
    # 设置物品窗口
    def item_window=(item_window)
    @item_window = item_window
    update
  end
end
