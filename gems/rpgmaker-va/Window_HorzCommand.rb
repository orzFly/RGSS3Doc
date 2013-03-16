#encoding:utf-8
# 横向选择的指令窗口
class Window_HorzCommand < Window_Command
    # 获取显示行数
    def visible_line_number
    return 1
  end
    # 获取列数
    def col_max
    return 4
  end
    # 获取行间距的宽度
    def spacing
    return 8
  end
    # 计算窗口内容的宽度
    def contents_width
    (item_width + spacing) * item_max - spacing
  end
    # 计算窗口内容的高度
    def contents_height
    item_height
  end
    # 获取首列位置
    def top_col
    ox / (item_width + spacing)
  end
    # 设置首列位置
    def top_col=(col)
    col = 0 if col < 0
    col = col_max - 1 if col > col_max - 1
    self.ox = col * (item_width + spacing)
  end
    # 获取尾列位置
    def bottom_col
    top_col + col_max - 1
  end
    # 设置尾列位置
    def bottom_col=(col)
    self.top_col = col - (col_max - 1)
  end
    # 确保光标在画面范围内滚动
    def ensure_cursor_visible
    self.top_col = index if index < top_col
    self.bottom_col = index if index > bottom_col
  end
    # 获取项目的绘制矩形
    def item_rect(index)
    rect = super
    rect.x = index * (item_width + spacing)
    rect.y = 0
    rect
  end
    # 获取对齐方向
    def alignment
    return 1
  end
    # 光标向下移动
    def cursor_down(wrap = false)
  end
    # 光标向上移动
    def cursor_up(wrap = false)
  end
    # 光标移至下一页
    def cursor_pagedown
  end
    # 光标移至上一页
    def cursor_pageup
  end
end
