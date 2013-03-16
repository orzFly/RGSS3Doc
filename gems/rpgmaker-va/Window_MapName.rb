#encoding:utf-8
# 显示地图名称的窗口。
class Window_MapName < Window_Base
    # 初始化对象
    def initialize
    super(0, 0, window_width, fitting_height(1))
    self.opacity = 0
    self.contents_opacity = 0
    @show_count = 0
    refresh
  end
    # 获取窗口的宽度
    def window_width
    return 240
  end
    # 更新画面
    def update
    super
    if @show_count > 0 && $game_map.name_display
      update_fadein
      @show_count -= 1
    else
      update_fadeout
    end
  end
    # 更新淡入
    def update_fadein
    self.contents_opacity += 16
  end
    # 更新淡出
    def update_fadeout
    self.contents_opacity -= 16
  end
    # 打开窗口
    def open
    refresh
    @show_count = 150
    self.contents_opacity = 0
    self
  end
    # 关闭窗口
    def close
    @show_count = 0
    self
  end
    # 刷新
    def refresh
    contents.clear
    unless $game_map.display_name.empty?
      draw_background(contents.rect)
      draw_text(contents.rect, $game_map.display_name, 1)
    end
  end
    # 绘制背景
    def draw_background(rect)
    temp_rect = rect.clone
    temp_rect.width /= 2
    contents.gradient_fill_rect(temp_rect, back_color2, back_color1)
    temp_rect.x = temp_rect.width
    contents.gradient_fill_rect(temp_rect, back_color1, back_color2)
  end
    # 获取背景色 1
    def back_color1
    Color.new(0, 0, 0, 192)
  end
    # 获取背景色 2
    def back_color2
    Color.new(0, 0, 0, 0)
  end
end
