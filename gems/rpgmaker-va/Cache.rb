#encoding:utf-8
# 此模块载入所有图像，建立并保存 Bitmap 对象。为加快载入速度并节省内存，
# 此模块将以建立的 bitmap 对象保存在内部哈希表中，使得程序在需要已存在
# 的图像时能快速读取 bitmap 对象。
module Cache
    # 获取动画图像
    def self.animation(filename, hue)
    load_bitmap("Graphics/Animations/", filename, hue)
  end
    # 获取战斗背景（地面）图像
    def self.battleback1(filename)
    load_bitmap("Graphics/Battlebacks1/", filename)
  end
    # 获取战斗背景（墙壁）图像
    def self.battleback2(filename)
    load_bitmap("Graphics/Battlebacks2/", filename)
  end
    # 获取战斗图
    def self.battler(filename, hue)
    load_bitmap("Graphics/Battlers/", filename, hue)
  end
    # 获取角色行走图
    def self.character(filename)
    load_bitmap("Graphics/Characters/", filename)
  end
    # 获取角色肖像图
    def self.face(filename)
    load_bitmap("Graphics/Faces/", filename)
  end
    # 获取远景图
    def self.parallax(filename)
    load_bitmap("Graphics/Parallaxes/", filename)
  end
    # 获取“图片”图像
    def self.picture(filename)
    load_bitmap("Graphics/Pictures/", filename)
  end
    # 获取系统图像
    def self.system(filename)
    load_bitmap("Graphics/System/", filename)
  end
    # 获取图块组图像
    def self.tileset(filename)
    load_bitmap("Graphics/Tilesets/", filename)
  end
    # 获取标题图像（背景）
    def self.title1(filename)
    load_bitmap("Graphics/Titles1/", filename)
  end
    # 获取标题图像（外框）
    def self.title2(filename)
    load_bitmap("Graphics/Titles2/", filename)
  end
    # 读取位图
    def self.load_bitmap(folder_name, filename, hue = 0)
    @cache ||= {}
    if filename.empty?
      empty_bitmap
    elsif hue == 0
      normal_bitmap(folder_name + filename)
    else
      hue_changed_bitmap(folder_name + filename, hue)
    end
  end
    # 生成空位图
    def self.empty_bitmap
    Bitmap.new(32, 32)
  end
    # 生成／获取普通的位图
    def self.normal_bitmap(path)
    @cache[path] = Bitmap.new(path) unless include?(path)
    @cache[path]
  end
    # 生成／获取色相变化后的位图
    def self.hue_changed_bitmap(path, hue)
    key = [path, hue]
    unless include?(key)
      @cache[key] = normal_bitmap(path).clone
      @cache[key].hue_change(hue)
    end
    @cache[key]
  end
    # 检查缓存是否存在
    def self.include?(key)
    @cache[key] && !@cache[key].disposed?
  end
    # 清空缓存
    def self.clear
    @cache ||= {}
    @cache.clear
    GC.start
  end
end
