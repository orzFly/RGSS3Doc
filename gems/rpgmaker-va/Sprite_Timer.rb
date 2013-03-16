#encoding:utf-8
# 显示计时器的精灵。根据 $game_timer 的状态自动变化。
class Sprite_Timer < Sprite
    # 初始化对象
    def initialize(viewport)
    super(viewport)
    create_bitmap
    update
  end
    # 释放
    def dispose
    self.bitmap.dispose
    super
  end
    # 生成位图
    def create_bitmap
    self.bitmap = Bitmap.new(96, 48)
    self.bitmap.font.size = 32
    self.bitmap.font.color.set(255, 255, 255)
  end
    # 更新画面
    def update
    super
    update_bitmap
    update_position
    update_visibility
  end
    # 更新源位图（Source Bitmap）
    def update_bitmap
    if $game_timer.sec != @total_sec
      @total_sec = $game_timer.sec
      redraw
    end
  end
    # 重绘
    def redraw
    self.bitmap.clear
    self.bitmap.draw_text(self.bitmap.rect, timer_text, 1)
  end
    # 生成绘制内容
    def timer_text
    sprintf("%02d:%02d", @total_sec / 60, @total_sec % 60)
  end
    # 更新位置
    def update_position
    self.x = Graphics.width - self.bitmap.width
    self.y = 0
    self.z = 200
  end
    # 更新可视状态
    def update_visibility
    self.visible = $game_timer.working?
  end
end
