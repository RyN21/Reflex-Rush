require "gosu"

module ZOrder
  BACKGROUND, PLAYER, BOUNCERS, UI = *0..3
end

WINDOW_WIDTH = 800
WINDOW_HEIGHT= 600
FLOOR_HEIGHT = 75
GRAVITY      = 1
JUMP_STRENGTH= -15

class Floor
    attr_reader :x, :y, :w, :h
    def initialize(x, y, w, h)
      @x = x
      @y = y
      @h = h
      @w = w
    end

    def draw
      Gosu.draw_rect(@x, @y, @w, @h, Gosu::Color::GREEN)
    end
end

class Player
  attr_reader :score
  def initialize
    @character_image = Gosu::Image.new("graphics/character_1_left.png")
    @beep            = Gosu::Sample.new("graphics/beep.wav")
    @floor           = 330
    @ceiling         = 125
    @x               = 300
    @y               = @floor
    @vel_x_left      = 5
    @vel_x_right     = 5
    @velocity_y      = 0
    @jump_vel        = 21
    @gravity_vel     = 1
    @vel_decrem      = 1
    @on_ground       = true
    @score           = 0
  end

  def on_ground?
    @on_ground ? true : false
  end

  def move_right
    @x += @vel_x_right
    if @x > 615
      @vel_x_right = 0
    else
      @vel_x_right = 5
    end
  end

  def move_left
    @x -= @vel_x_left
    if @x < -60
      @vel_x_left = 0
    else
      @vel_x_left = 5
    end
  end

  def jump
    @jump_vel -= 1
    @y -= @jump_vel
    if @y >= @floor
      @jump_vel = 21
    end
  end

  def gravity
    @gravity_vel += 1.4
    @y += @gravity_vel
    if @y >= @floor
      @y = @floor
      on_ground = true
      @gravity_vel = 1
      @jump_vel = 21
    end
  end

  def draw
    @character_image.draw @x, @y, 0, scale_x=0.30, scale_y=0.30
  end
end

class Bouncer

end



TITLE  = "Reflux Rush"

class Game < Gosu::Window
  def initialize(width = 800, height = 600)
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = TITLE

    @background_image = Gosu::Image.new("graphics/background_1.png")
    @floor  = Floor.new(0, WINDOW_HEIGHT - FLOOR_HEIGHT, WINDOW_WIDTH, FLOOR_HEIGHT)
    @player = Player.new
  end

  def update
    if Gosu.button_down? Gosu::KB_LEFT
      @player.move_left
    end
    if Gosu.button_down? Gosu::KB_RIGHT
      @player.move_right
    end
    if Gosu.button_down? Gosu::KB_SPACE
      @player.jump
    end
    if !Gosu.button_down? Gosu::KB_SPACE
      @player.gravity
    end
  end

  def draw
    @background_image.draw -15, 0, 0, 1.60, 1.18
    @player.draw
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      close
    end
  end
end






Game.new.show



# WIDTH  = 800
# HEIGHT = 600
# TITLE  = "Reflux Rush"
#
# class Game < Gosu::Window
#   def initialize(width = 800, height = 600, borderless? = false)
#     super(width, height)
#     self.caption = TITLE
#
#     @background = Gosu::Image.new("graphics/background_1.png")
#
#     @sprite      = Gosu::Image.new("graphics/character_1_left.png")
#     @sprite_x    = 200
#     @sprite_y    = 330
#     @floor       = 330
#     @sprite_xvel = 5
#     @jump_vel    = 20
#     @gravity_vel = 5
#     @vel_decrem  = 2
#     @jumping     = false
#   end
#
#   def update
#     update_sprite
#   end
#
#   def draw
#     @background.draw -15, 0, 0, 1.60, 1.18
#     @sprite.draw @sprite_x, @sprite_y, 0, scale_x=0.30, scale_y=0.30
#   end
#
#   def button_down id
#     case id
#     when Gosu::KB_ESCAPE
#       close
#     end
#   end
#
#   def update_sprite
#     if Gosu.button_down?(Gosu::KB_LEFT)
#       @sprite_x -= @sprite_xvel
#     end
#     if Gosu.button_down?(Gosu::KB_RIGHT)
#       @sprite_x += @sprite_xvel
#     end
#     if Gosu.button_down?(Gosu::KB_SPACE)
#       @sprite_y -= @jump_vel -= 1
#     end
#     # @sprite_y += @sprite_yvel until @sprite_y == 330
#     if !Gosu.button_down?(Gosu::KB_SPACE) && @sprite_y <= 330
#       @sprite_y += @gravity_vel
#     end
#     # if button_down(Gosu::KB_SPACE)
#     #   jump
#     # end
#   end
# end
