#encoding:utf-8
# 管理地图的类。拥有卷动地图以及判断通行度的功能。
# 本类的实例请参考 $game_map 。
class Game_Map
    # 定义实例变量
    attr_reader   :screen                   # 地图画面的状态
  attr_reader   :interpreter              # 地图事件用事件解释器
  attr_reader   :events                   # 事件
  attr_reader   :display_x                # 显示 X 坐标
  attr_reader   :display_y                # 显示 Y 坐标
  attr_reader   :parallax_name            # 远景图文件名
  attr_reader   :vehicles                 # 载具
  attr_reader   :battleback1_name         # 战斗背景（地面）文件名
  attr_reader   :battleback2_name         # 战斗背景（墙壁）文件名
  attr_accessor :name_display             # 地图名显示的标志
  attr_accessor :need_refresh             # 刷新要求的标志
    # 初始化对象
    def initialize
    @screen = Game_Screen.new
    @interpreter = Game_Interpreter.new
    @map_id = 0
    @events = {}
    @display_x = 0
    @display_y = 0
    create_vehicles
    @name_display = true
  end
    # 设置
    def setup(map_id)
    @map_id = map_id
    @map = load_data(sprintf("Data/Map%03d.rvdata2", @map_id))
    @tileset_id = @map.tileset_id
    @display_x = 0
    @display_y = 0
    referesh_vehicles
    setup_events
    setup_scroll
    setup_parallax
    setup_battleback
    @need_refresh = false
  end
    # 生成载具
    def create_vehicles
    @vehicles = []
    @vehicles[0] = Game_Vehicle.new(:boat)
    @vehicles[1] = Game_Vehicle.new(:ship)
    @vehicles[2] = Game_Vehicle.new(:airship)
  end
    # 更新载具
    def referesh_vehicles
    @vehicles.each {|vehicle| vehicle.refresh }
  end
    # 获取载具
    def vehicle(type)
    return @vehicles[0] if type == :boat
    return @vehicles[1] if type == :ship
    return @vehicles[2] if type == :airship
    return nil
  end
    # 获取小舟
    def boat
    @vehicles[0]
  end
    # 获取大船
    def ship
    @vehicles[1]
  end
    # 获取飞艇
    def airship
    @vehicles[2]
  end
    # 设置事件
    def setup_events
    @events = {}
    @map.events.each do |i, event|
      @events[i] = Game_Event.new(@map_id, event)
    end
    @common_events = parallel_common_events.collect do |common_event|
      Game_CommonEvent.new(common_event.id)
    end
    refresh_tile_events
  end
    # 获取并行处理的公共事件的数组
    def parallel_common_events
    $data_common_events.select {|event| event && event.parallel? }
  end
    # 设置卷动
    def setup_scroll
    @scroll_direction = 2
    @scroll_rest = 0
    @scroll_speed = 4
  end
    # 设置远景图
    def setup_parallax
    @parallax_name = @map.parallax_name
    @parallax_loop_x = @map.parallax_loop_x
    @parallax_loop_y = @map.parallax_loop_y
    @parallax_sx = @map.parallax_sx
    @parallax_sy = @map.parallax_sy
    @parallax_x = 0
    @parallax_y = 0
  end
    # 设置战斗背景
    def setup_battleback
    if @map.specify_battleback
      @battleback1_name = @map.battleback1_name
      @battleback2_name = @map.battleback2_name
    else
      @battleback1_name = nil
      @battleback2_name = nil
    end
  end
    # 设置显示位置
    def set_display_pos(x, y)
    x = [0, [x, width - screen_tile_x].min].max unless loop_horizontal?
    y = [0, [y, height - screen_tile_y].min].max unless loop_vertical?
    @display_x = (x + width) % width
    @display_y = (y + height) % height
    @parallax_x = x
    @parallax_y = y
  end
    # 计算远景图显示的原点 X 坐标
    def parallax_ox(bitmap)
    if @parallax_loop_x
      @parallax_x * 16
    else
      w1 = [bitmap.width - Graphics.width, 0].max
      w2 = [width * 32 - Graphics.width, 1].max
      @parallax_x * 16 * w1 / w2
    end
  end
    # 计算远景图显示的原点 Y 坐标
    def parallax_oy(bitmap)
    if @parallax_loop_y
      @parallax_y * 16
    else
      h1 = [bitmap.height - Graphics.height, 0].max
      h2 = [height * 32 - Graphics.height, 1].max
      @parallax_y * 16 * h1 / h2
    end
  end
    # 获取地图 ID
    def map_id
    @map_id
  end
    # 获取图块组
    def tileset
    $data_tilesets[@tileset_id]
  end
    # 获取显示名称
    def display_name
    @map.display_name
  end
    # 获取宽度
    def width
    @map.width
  end
    # 获取高度
    def height
    @map.height
  end
    # 获取是否横向循环
    def loop_horizontal?
    @map.scroll_type == 2 || @map.scroll_type == 3
  end
    # 获取是否纵向循环
    def loop_vertical?
    @map.scroll_type == 1 || @map.scroll_type == 3
  end
    # 获取是否禁止跑步
    def disable_dash?
    @map.disable_dashing
  end
    # 获取遇敌列表
    def encounter_list
    @map.encounter_list
  end
    # 获取遇敌步数
    def encounter_step
    @map.encounter_step
  end
    # 获取地图数据
    def data
    @map.data
  end
    # 是否环球类型
    def overworld?
    tileset.mode == 0
  end
    # 画面的横向图块数
    def screen_tile_x
    Graphics.width / 32
  end
    # 画面的纵向图块数
    def screen_tile_y
    Graphics.height / 32
  end
    # 计算显示坐标的剩余 X 坐标
    def adjust_x(x)
    if loop_horizontal? && x < @display_x - (width - screen_tile_x) / 2
      x - @display_x + @map.width
    else
      x - @display_x
    end
  end
    # 计算显示坐标的剩余 Y 坐标
    def adjust_y(y)
    if loop_vertical? && y < @display_y - (height - screen_tile_y) / 2
      y - @display_y + @map.height
    else
      y - @display_y
    end
  end
    # 计算循环修正后的 X 坐标
    def round_x(x)
    loop_horizontal? ? (x + width) % width : x
  end
    # 计算循环修正后的 Y 坐标
    def round_y(y)
    loop_vertical? ? (y + height) % height : y
  end
    # 计算特定方向推移一个图块的 X 坐标（没有循环修正）
    def x_with_direction(x, d)
    x + (d == 6 ? 1 : d == 4 ? -1 : 0)
  end
    # 计算特定方向推移一个图块的 Y 坐标（没有循环修正）
    def y_with_direction(y, d)
    y + (d == 2 ? 1 : d == 8 ? -1 : 0)
  end
    # 计算特定方向推移一个图块的 X 坐标（没有循环修正）
    def round_x_with_direction(x, d)
    round_x(x + (d == 6 ? 1 : d == 4 ? -1 : 0))
  end
    # 计算特定方向推移一个图块的 Y 坐标（没有循环修正）
    def round_y_with_direction(y, d)
    round_y(y + (d == 2 ? 1 : d == 8 ? -1 : 0))
  end
    # 自动切换 BGM / BGS 
    def autoplay
    @map.bgm.play if @map.autoplay_bgm
    @map.bgs.play if @map.autoplay_bgs
  end
    # 刷新
    def refresh
    @events.each_value {|event| event.refresh }
    @common_events.each {|event| event.refresh }
    refresh_tile_events
    @need_refresh = false
  end
    # 更新图块事件的数组
    def refresh_tile_events
    @tile_events = @events.values.select {|event| event.tile? }
  end
    # 获取指定坐标处存在的事件的数组
    def events_xy(x, y)
    @events.values.select {|event| event.pos?(x, y) }
  end
    # 获取指定坐标处存在的事件（穿透以外）的数组
    def events_xy_nt(x, y)
    @events.values.select {|event| event.pos_nt?(x, y) }
  end
    # 获取指定坐标处存在的图块事件（穿透以外）的数组
    def tile_events_xy(x, y)
    @tile_events.select {|event| event.pos_nt?(x, y) }
  end
    # 获取指定坐标处存在的事件的 ID （仅一个）
    def event_id_xy(x, y)
    list = events_xy(x, y)
    list.empty? ? 0 : list[0].id
  end
    # 向下卷动
    def scroll_down(distance)
    if loop_vertical?
      @display_y += distance
      @display_y %= @map.height
      @parallax_y += distance if @parallax_loop_y
    else
      last_y = @display_y
      @display_y = [@display_y + distance, height - screen_tile_y].min
      @parallax_y += @display_y - last_y
    end
  end
    # 向左卷动
    def scroll_left(distance)
    if loop_horizontal?
      @display_x += @map.width - distance
      @display_x %= @map.width 
      @parallax_x -= distance if @parallax_loop_x
    else
      last_x = @display_x
      @display_x = [@display_x - distance, 0].max
      @parallax_x += @display_x - last_x
    end
  end
    # 向右卷动
    def scroll_right(distance)
    if loop_horizontal?
      @display_x += distance
      @display_x %= @map.width
      @parallax_x += distance if @parallax_loop_x
    else
      last_x = @display_x
      @display_x = [@display_x + distance, (width - screen_tile_x)].min
      @parallax_x += @display_x - last_x
    end
  end
    # 向上卷动
    def scroll_up(distance)
    if loop_vertical?
      @display_y += @map.height - distance
      @display_y %= @map.height
      @parallax_y -= distance if @parallax_loop_y
    else
      last_y = @display_y
      @display_y = [@display_y - distance, 0].max
      @parallax_y += @display_y - last_y
    end
  end
    # 有效坐标判定
    def valid?(x, y)
    x >= 0 && x < width && y >= 0 && y < height
  end
    # 通行检查
  # bit : 判断通行禁止与否的字节（请参照二进制运算）
    def check_passage(x, y, bit)
    all_tiles(x, y).each do |tile_id|
      flag = tileset.flags[tile_id]
      next if flag & 0x10 != 0            # [☆] : 不影响通行
      return true  if flag & bit == 0     # [○] : 可以通行
      return false if flag & bit == bit   # [×] : 不能通行
    end
    return false                          # 不能通行
  end
    # 获取指定坐标处的图块 ID 
    def tile_id(x, y, z)
    @map.data[x, y, z] || 0
  end
    # （由上至下）获取指定坐标处所有层次的图块数组
    def layered_tiles(x, y)
    [2, 1, 0].collect {|z| tile_id(x, y, z) }
  end
    # 获取指定坐标处的所有图块数组（包括事件）
    def all_tiles(x, y)
    tile_events_xy(x, y).collect {|ev| ev.tile_id } + layered_tiles(x, y)
  end
    # 获取指定坐标处的自动原件种类
    def autotile_type(x, y, z)
    tile_id(x, y, z) >= 2048 ? (tile_id(x, y, z) - 2048) / 48 : -1
  end
    # 判定普通角色是否可以通行
  # d : 方向（2,4,6,8）
  # 判断该位置的图块指定方向的通行度。
    def passable?(x, y, d)
    check_passage(x, y, (1 << (d / 2 - 1)) & 0x0f)
  end
    # 判定小舟是否可以通行
    def boat_passable?(x, y)
    check_passage(x, y, 0x0200)
  end
    # 判定大船是否可以通行
    def ship_passable?(x, y)
    check_passage(x, y, 0x0400)
  end
    # 判定飞艇是否可以着陆
    def airship_land_ok?(x, y)
    check_passage(x, y, 0x0800) && check_passage(x, y, 0x0f)
  end
    # 判定指定坐标处所有层次的标志
    def layered_tiles_flag?(x, y, bit)
    layered_tiles(x, y).any? {|tile_id| tileset.flags[tile_id] & bit != 0 }
  end
    # 判定是否梯子
    def ladder?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x20)
  end
    # 判定是否草木茂密处
    def bush?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x40)
  end
    # 判定是否柜台属性
    def counter?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x80)
  end
    # 判定是否有害地形
    def damage_floor?(x, y)
    valid?(x, y) && layered_tiles_flag?(x, y, 0x100)
  end
    # 获取地形标志
    def terrain_tag(x, y)
    return 0 unless valid?(x, y)
    layered_tiles(x, y).each do |tile_id|
      tag = tileset.flags[tile_id] >> 12
      return tag if tag > 0
    end
    return 0
  end
    # 获取区域 ID 
    def region_id(x, y)
    valid?(x, y) ? @map.data[x, y, 3] >> 8 : 0
  end
    # 开始卷动
    def start_scroll(direction, distance, speed)
    @scroll_direction = direction
    @scroll_rest = distance
    @scroll_speed = speed
  end
    # 判定是否卷动中
    def scrolling?
    @scroll_rest > 0
  end
    # 更新画面
  # main : 事件解释器更新的标志
    def update(main = false)
    refresh if @need_refresh
    update_interpreter if main
    update_scroll
    update_events
    update_vehicles
    update_parallax
    @screen.update
  end
    # 更新卷动
    def update_scroll
    return unless scrolling?
    last_x = @display_x
    last_y = @display_y
    do_scroll(@scroll_direction, scroll_distance)
    if @display_x == last_x && @display_y == last_y
      @scroll_rest = 0
    else
      @scroll_rest -= scroll_distance
    end
  end
    # 计算卷动的距离
    def scroll_distance
    2 ** @scroll_speed / 256.0
  end
    # 执行卷动
    def do_scroll(direction, distance)
    case direction
    when 2;  scroll_down (distance)
    when 4;  scroll_left (distance)
    when 6;  scroll_right(distance)
    when 8;  scroll_up   (distance)
    end
  end
    # 更新事件
    def update_events
    @events.each_value {|event| event.update }
    @common_events.each {|event| event.update }
  end
    # 更新载具
    def update_vehicles
    @vehicles.each {|vehicle| vehicle.update }
  end
    # 更新远景图
    def update_parallax
    @parallax_x += @parallax_sx / 64.0 if @parallax_loop_x
    @parallax_y += @parallax_sy / 64.0 if @parallax_loop_y
  end
    # 更改图块组
    def change_tileset(tileset_id)
    @tileset_id = tileset_id
    refresh
  end
    # 更改战斗背景
    def change_battleback(battleback1_name, battleback2_name)
    @battleback1_name = battleback1_name
    @battleback2_name = battleback2_name
  end
    # 更改远景图
    def change_parallax(name, loop_x, loop_y, sx, sy)
    @parallax_name = name
    @parallax_x = 0 if @parallax_loop_x && !loop_x
    @parallax_y = 0 if @parallax_loop_y && !loop_y
    @parallax_loop_x = loop_x
    @parallax_loop_y = loop_y
    @parallax_sx = sx
    @parallax_sy = sy
  end
    # 更新事件解释器
    def update_interpreter
    loop do
      @interpreter.update
      return if @interpreter.running?
      if @interpreter.event_id > 0
        unlock_event(@interpreter.event_id)
        @interpreter.clear
      end
      return unless setup_starting_event
    end
  end
    # 解锁事件
    def unlock_event(event_id)
    @events[event_id].unlock if @events[event_id]
  end
    # 设置启动中事件
    def setup_starting_event
    refresh if @need_refresh
    return true if @interpreter.setup_reserved_common_event
    return true if setup_starting_map_event
    return true if setup_autorun_common_event
    return false
  end
    # 判定是否拥有启动中地图事件
    def any_event_starting?
    @events.values.any? {|event| event.starting }
  end
    # 检测／设置启动中的地图事件
    def setup_starting_map_event
    event = @events.values.find {|event| event.starting }
    event.clear_starting_flag if event
    @interpreter.setup(event.list, event.id) if event
    event
  end
    # 检测／设置自动执行的公共事件
    def setup_autorun_common_event
    event = $data_common_events.find do |event|
      event && event.autorun? && $game_switches[event.switch_id]
    end
    @interpreter.setup(event.list) if event
    event
  end
end
