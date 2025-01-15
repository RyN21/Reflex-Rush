require "gosu"

class BonusPoint
  attr_reader :x, :y

  def initialize
    pu1_image   = Gosu::Image.new("graphics/ruby.png")
    @power_up_1 = pu1_image.subimage(50,50,750,675)
    @x          = rand 50..750
    @y          = -50
    @vel        = 4
  end

  def draw
    @power_up_1.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu.milliseconds / 133.7), center_x = 0.5, center_y = 0.5, scale_x = 0.05, scale_y = 0.05)
    # draw_border(@x, @y, @power_up_1.width * 0.05, @power_up_1.height * 0.05)
  end

  def update_bonus_point
    @y += @vel
  end

  def draw_border(x, y, w, h)
    Gosu.draw_line(x - @power_up_1.width/2 * 0.05, y - @power_up_1.height/2 *0.05, Gosu::Color::RED, x - @power_up_1.width/2 *0.05 + w, y - @power_up_1.height/2 *0.05, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.05 + w, y - @power_up_1.height/2 *0.05, Gosu::Color::RED, x - @power_up_1.width/2 * 0.05 + w, y - @power_up_1.height/2 *0.05 + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.05 + w, y - @power_up_1.height/2 *0.05 + h, Gosu::Color::RED, x - @power_up_1.width/2 * 0.05, y - @power_up_1.height/2 *0.05 + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x - @power_up_1.width/2 * 0.05, y - @power_up_1.height/2 *0.05 + h, Gosu::Color::RED, x - @power_up_1.width/2 * 0.05, y - @power_up_1.height/2 *0.05, Gosu::Color::RED, 1) #left border
  end
end
