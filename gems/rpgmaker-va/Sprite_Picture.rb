#encoding:utf-8
# 显示图片用的精灵。根据 Game_Picture 类的实例的状态自动变化。
class Sprite_Picture < Sprite
    # 初始化对象
  # picture : Game_Picture
    def initialize(viewport, picture)
    super(viewport)
    @picture = picture
    update
  end
    # 释放
    def dispose
    bitmap.dispose if bitmap
    super
  end
    # 更新画面
    def update
    super
    update_bitmap
    update_origin
    update_position
    update_zoom
    update_other
  end
    # 更新源位图（Source Bitmap）
    def update_bitmap
    self.bitmap = Cache.picture(@picture.name)
  end
    # 更新原点
    def update_origin
    if @picture.origin == 0
      self.ox = 0
      self.oy = 0
    else
      self.ox = bitmap.width / 2
      self.oy = bitmap.height / 2
    end
  end
    # 更新位置
    def update_position
    self.x = @picture.x
    self.y = @picture.y
    self.z = @picture.number
  end
    # 更新缩放率
    def update_zoom
    self.zoom_x = @picture.zoom_x / 100.0
    self.zoom_y = @picture.zoom_y / 100.0
  end
    # 更新其他
    def update_other
    self.opacity = @picture.opacity
    self.blend_type = @picture.blend_type
    self.angle = @picture.angle
    self.tone.set(@picture.tone)
  end
end
