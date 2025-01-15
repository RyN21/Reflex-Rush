require "gosu"

WIDTH  = 800
HEIGHT = 600
TITLE  = "Reflux Rush"

class Game < Gosu::Window
  def initialize(width = 800, height = 600)
    super(width, height)
    self.caption = TITLE

    @background = Gosu::Image.new("graphics/background_1.png")

    @sprite      = Gosu::Image.new("graphics/character_1_left.png")
    # @sprite_right= Gosu::Image.new("graphics/character_right.png")
    @sprite_x    = 200
    @sprite_y    = 330
    @sprite_xvel = 5
    @sprite_yvel = 20
    @gravity_vel = 10
    @jumping     = false
  end

  def update
    update_sprite
  end

  def draw
    @background.draw -15, 0, 0, 1.60, 1.18
    @sprite.draw @sprite_x, @sprite_y, 0, scale_x=0.30, scale_y=0.30
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      close
    # when Gosu::KB_SPACE
    #   jump
    end
  end

  def update_sprite
    if Gosu.button_down?(Gosu::KB_LEFT)
      @sprite_x -= @sprite_xvel
    end
    if Gosu.button_down?(Gosu::KB_RIGHT)
      @sprite_x += @sprite_xvel
    end
    if @sprite_y < 330
      @sprite_y += @gravity_vel
    end
    if Gosu.button_down?(Gosu::KB_SPACE) && @sprite_y <= 330
      @sprite_y -= @sprite_yvel
    end
    #   @sprite_y += @sprite_yvel until @sprite_y == 330
    # end
    # if Gosu.button_down?(Gosu::KB_SPACE) == false && @sprite_y >= 250
    #   @sprite_y += @gravity_vel until @sprite_y == 330
    # end
  end

  def jump
    300.times do
      @sprite_y -= 0.25
    end
  end
  def gravity
    @sprite_y += 40
  end
end


Game.new.show
