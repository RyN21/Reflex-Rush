require "gosu"

class Shrink
  attr_reader :x, :y

  def initialize
    shrink_image = Gosu::Image.new("graphics/shrink.png")
    @shrink      = shrink_image.subimage(50,50,750,675)
    @x           = rand 50..750
    @y           = -50
    @vel         = 3
  end

  def draw
    @shrink.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu.milliseconds / 133.7), center_x = 0.5, center_y = 0.5, scale_x = 0.05, scale_y = 0.05)
    draw_border(@x, @y, @shrink.width * 0.05, @shrink.height * 0.05)
  end

  def update_shrink
    @y += @vel
  end

  def draw_border(x, y, w, h)
    Gosu.draw_line(x - @shrink.width/2 * 0.05, y - @shrink.height/2 *0.05, Gosu::Color::RED, x - @shrink.width/2 *0.05 + w, y - @shrink.height/2 *0.05, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x - @shrink.width/2 * 0.05 + w, y - @shrink.height/2 *0.05, Gosu::Color::RED, x - @shrink.width/2 * 0.05 + w, y - @shrink.height/2 *0.05 + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x - @shrink.width/2 * 0.05 + w, y - @shrink.height/2 *0.05 + h, Gosu::Color::RED, x - @shrink.width/2 * 0.05, y - @shrink.height/2 *0.05 + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x - @shrink.width/2 * 0.05, y - @shrink.height/2 *0.05 + h, Gosu::Color::RED, x - @shrink.width/2 * 0.05, y - @shrink.height/2 *0.05, Gosu::Color::RED, 1) #left border
  end
end
