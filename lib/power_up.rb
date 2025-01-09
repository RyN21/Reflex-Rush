require "gosu"

class PowerUp
  attr_reader :x, :y

  def initialize
    pu1_image  = Gosu::Image.new("graphics/ruby.png")
    @power_up_1 = pu1_image.subimage(148,170,300,262)
    @x          = 300
    @y          = 50
    @vel        = rand 3..7
    @width      = 75
    @height     = 75
  end

  def draw
    @power_up_1.draw_rot(@x,@y,0,  5, center_x = 0.5, center_y = 0.5, scale_x = 0.25, scale_y = 0.25)
  end

  def update_power_up

  end

  def draw_border(x, y, w, h)
    Gosu.draw_line(x - @power_up_1.width/2 * 0.15, y - @power_up_1.height/2 *0.15, Gosu::Color::RED, x - @power_up_1.width/2 *0.15 + w, y - @power_up_1.height/2 *0.15, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.15 + w, y - @power_up_1.height/2 *0.15, Gosu::Color::RED, x - @power_up_1.width/2 * 0.15 + w, y - @power_up_1.height/2 *0.15 + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.15 + w, y - @power_up_1.height/2 *0.15 + h, Gosu::Color::RED, x - @power_up_1.width/2 * 0.15, y - @power_up_1.height/2 *0.15 + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.15, y - @power_up_1.height/2 *0.15 + h, Gosu::Color::RED, x - @power_up_1.width/2 * 0.15, y - @power_up_1.height/2 *0.15, Gosu::Color::RED, 1) #left border
  end
end
