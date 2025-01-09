require "gosu"

class Rock
  attr_reader :x, :y
  def initialize(difficulty)
    rock_image  = Gosu::Image.new("graphics/rock.png")
    @rock       = rock_image.subimage(148,170,300,262)
    @floor      = FLOOR + @rock.height * 0.15
    @x          = rand 0..800
    @y          = 0
    @vel        = difficulty
    @x_vel      = @vel
    @y_vel      = @vel
    @width      = 50
    @height     = 50
    @update_score = false
  end

  def draw
    @rock.draw_rot(@x,@y,0,  25 * Math.sin(Gosu.milliseconds / 133.7), center_x = 0.5, center_y = 0.5, scale_x = 0.15, scale_y = 0.15)
    # draw_border(@x, @y, @rock.width * 0.15, @rock.height * 0.15)
  end

  def update_rock
    @x += @x_vel
    @y += @y_vel
    if @x < 0 + 25
      @x_vel = @vel
    elsif @x + 25 > WINDOW_WIDTH
      @x_vel = -@vel
    end
    if @y <= 0
      @y_vel = @vel
    elsif @y + @height > @floor
      @y_vel = -@vel
    end
    if @y == 0
      @update_score = true
    elsif
      @update_score = false
    end
  end

  def update_score?
    @update_score
  end
  # def draw_border(x, y, w, h)
  #   Gosu.draw_line(x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15, Gosu::Color::RED, x - @rock.width/2 *0.15 + w, y - @rock.height/2 *0.15, Gosu::Color::RED, 1) #top border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15, Gosu::Color::RED, x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, 1) #right border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, 1) #bottom border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15, Gosu::Color::RED, 1) #left border
  # end
end
