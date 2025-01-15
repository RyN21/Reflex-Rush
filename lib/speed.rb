require "gosu"

class Speed
  attr_reader :x, :y

  def initialize
    speed_image = Gosu::Image.new("graphics/speed.png")
    @speed      = speed_image.subimage(50,50,750,675)
    @x           = rand 50..750
    @y           = -50
    @vel         = 5
  end

  def draw
    @speed.draw_rot(@x, @y, 0, 25 * Math.sin(Gosu.milliseconds / 133.7), center_x = 0.5, center_y = 0.5, scale_x = 0.08, scale_y = 0.08)
    draw_border(@x, @y, @speed.width * 0.08, @speed.height * 0.08)
  end

  def update_speed
    @y += @vel
  end

  def draw_border(x, y, w, h)
    Gosu.draw_line(x - @speed.width/2 * 0.08, y - @speed.height/2 *0.08, Gosu::Color::RED, x - @speed.width/2 *0.08 + w, y - @speed.height/2 *0.08, Gosu::Color::RED, 1) #top border
    Gosu.draw_line(x - @speed.width/2 * 0.08 + w, y - @speed.height/2 *0.08, Gosu::Color::RED, x - @speed.width/2 * 0.08 + w, y - @speed.height/2 *0.08 + h, Gosu::Color::RED, 1) #right border
    Gosu.draw_line(x - @speed.width/2 * 0.08 + w, y - @speed.height/2 *0.08 + h, Gosu::Color::RED, x - @speed.width/2 * 0.08, y - @speed.height/2 *0.08 + h, Gosu::Color::RED, 1) #bottom border
    Gosu.draw_line(x - @speed.width/2 * 0.08, y - @speed.height/2 *0.08 + h, Gosu::Color::RED, x - @speed.width/2 * 0.08, y - @speed.height/2 *0.08, Gosu::Color::RED, 1) #left border
  end
end
