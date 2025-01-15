require "gosu"

class Player
  attr_reader :score
  def initialize
    @char_image   = Gosu::Image.new("graphics/character_1.png")
    @player       = @char_image.subimage(210,160,390,495)
    @hit_sound    = Gosu::Sample.new("sounds/hit_4.mp3")
    @bonus_sound  = Gosu::Sample.new("sounds/level_up.mp3")
    @player_scale = 0.30
    @floor        = FLOOR - @player.height * @player_scale
    @ceiling      = 125
    @x            = 300
    @y            = @floor
    @player_speed = 8
    @vel_x_left   = @player_speed
    @vel_x_right  = @player_speed
    @velocity_y   = 0
    @jump_vel     = 26
    @gravity_vel  = 1
    @vel_decrem   = 1
    @on_ground    = true
    @score        = 0
    @direction    = nil
    @damage       = 25
    @victory      = false
    @shrunk       = false
    @sped_up      = false
  end

  def on_ground?
    @on_ground ? true : false
  end

  def move_right
    @x += @vel_x_right
    if @x > WINDOW_WIDTH - @player.width * @player_scale
      @vel_x_right = 0
    else
      @vel_x_right = @player_speed
    end
    @direction = -@player_scale
    @x + @player.width * @player_scale
  end

  def move_left
    @x -= @vel_x_left
    if @x < 0
      @vel_x_left = 0
    else
      @vel_x_left = @player_speed
    end
    @direction = @player_scale
  end

  def jump
    @jump_vel -= 1
    @y -= @jump_vel
    if @y >= @floor
      @jump_vel = 26
    end
  end

  def gravity
    @gravity_vel += 1.4
    @y += @gravity_vel
    if @y >= @floor
      @y = @floor
      on_ground = true
      @gravity_vel = 1
      @jump_vel = 26
    end
  end

  def draw
    scale_x = @direction == @player_scale ? @player_scale:-@player_scale
    adjusted_scale_x = scale_x == -@player_scale ? @x + @player.width * @player_scale : @x
    @player.draw adjusted_scale_x, @y, 0, scale_x, scale_y = @player_scale
    # draw_border(@x, @y, @player.width * 0.3, @player.height * 0.3)
  end

  def gets_hit(rocks)
    rocks.reject! do |rock|
      if Gosu.distance(@x + @player.width/2 *@player_scale, @y + @player.height / 2 *@player_scale, rock.x, rock.y) < 80
        @score -= @damage
        @hit_sound.play
      else
        false
      end
    end

    def bonus_point(bonus_points)
      bonus_points.reject! do |bonus_point|
        if Gosu.distance(@x + @player.width/2 *@player_scale, @y + @player.height / 2 *@player_scale, bonus_point.x, bonus_point.y) < 80
          @score += 25
          @bonus_sound.play
        else
          false
        end
      end
    end

    def shrink(shrinks)
      shrinks.reject! do |shrink|
        if Gosu.distance(@x + @player.width/2 *@player_scale, @y + @player.height / 2 *@player_scale, shrink.x, shrink.y) < 80
          @player_scale = 0.15
          @bonus_sound.play
          @floor = FLOOR - @player.height * @player_scale
          @shrunk = true
          Thread.new do
            sleep(9)
            unshrink
          end
        else
          false
        end
      end
    end

    def unshrink
      @player_scale = 0.30
      @floor = FLOOR - @player.height * @player_scale
      @shrunk = false
    end

    def speed_up(speeds)
      speeds.reject! do |speed|
        if Gosu.distance(@x + @player.width/2 *@player_scale, @y + @player.height / 2 *@player_scale, speed.x, speed.y) < 80
          @player_speed = 15
          @bonus_sound.play
          Thread.new do
            sleep(9)
            unspeed
          end
        else
          false
        end
      end
    end

    def unspeed
      @player_speed = 8
    end


    def add_points(rocks)
      rocks.each do |rock|
        @score += 15 if rock.update_score?
      end
    end
  end

  def level_up
    @score = 0
    @damage += 5
  end

  def game_over
    @score = 0
  end

  def victory?(level, backgrounds)
    level == backgrounds.length ? @victory = true : @victory = false
  end
  # def draw_border(x, y, w, h)
  #   Gosu.draw_line(x, y, Gosu::Color::RED, x + w, y, Gosu::Color::RED, 1) #top border
  #   Gosu.draw_line(x + w, y, Gosu::Color::RED, x + w, y + h, Gosu::Color::RED, 1) #right border
  #   Gosu.draw_line(x + w, y + h, Gosu::Color::RED, x, y + h, Gosu::Color::RED, 1) #bottom border
  #   Gosu.draw_line(x, y + h, Gosu::Color::RED, x, y, Gosu::Color::RED, 1) #left border
  # end
end
