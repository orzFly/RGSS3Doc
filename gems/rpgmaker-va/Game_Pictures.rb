#encoding:utf-8
# 包装了图片数组的外壳。本类在 Game_Screen 类的内部使用。地图图块图像和战斗图
# 像另行处理。
class Game_Pictures
    # 初始化对象
    def initialize
    @data = []
  end
    # 获取图片
    def [](number)
    @data[number] ||= Game_Picture.new(number)
  end
    # 迭代
    def each
    @data.compact.each {|picture| yield picture } if block_given?
  end
end
