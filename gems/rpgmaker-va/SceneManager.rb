#encoding:utf-8
# 场景切换的管理器。 RGSS3 内置了新功能，在使用 call 方法切换新场景时，可以
# 用 return 方法返回上一个场景。
module SceneManager
    # 模块的实例变量
    @scene = nil                            # 当前场景实例
  @stack = []                             # 场景切换的记录
  @background_bitmap = nil                # 背景用的场景截图
    # 运行
    def self.run
    DataManager.init
    Audio.setup_midi if use_midi?
    @scene = first_scene_class.new
    @scene.main while @scene
  end
    # 获取最初场景的所属类
    def self.first_scene_class
    $BTEST ? Scene_Battle : Scene_Title
  end
    # 是否使用 MIDI 
    def self.use_midi?
    $data_system.opt_use_midi
  end
    # 获取当前场景
    def self.scene
    @scene
  end
    # 判定当前场景的所属类
    def self.scene_is?(scene_class)
    @scene.instance_of?(scene_class)
  end
    # 直接切换某个场景（无过渡）
    def self.goto(scene_class)
    @scene = scene_class.new
  end
    # 切换
    def self.call(scene_class)
    @stack.push(@scene)
    @scene = scene_class.new
  end
    # 返回到上一个场景
    def self.return
    @scene = @stack.pop
  end
    # 清空场景切换的记录
    def self.clear
    @stack.clear
  end
    # 退出游戏
    def self.exit
    @scene = nil
  end
    # 生成背景用的场景截图
    def self.snapshot_for_background
    @background_bitmap.dispose if @background_bitmap
    @background_bitmap = Graphics.snap_to_bitmap
    @background_bitmap.blur
  end
    # 获取背景用的场景截图
    def self.background_bitmap
    @background_bitmap
  end
end
