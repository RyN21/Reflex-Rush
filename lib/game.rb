# require "chunky_png"
# image        = ChunkyPNG::Image.from_file("graphics/character_1.png")
# scaled_h     = (image.height * 0.30).to_i
# scaled_w     = (image.width * 0.30).to_i
# downscaled   = image.resample_nearest_neighbor(scaled_w, scaled_h)
# @player_image= Gosu::Image.from_blob(downscaled.width, downscaled.height)
require "gosu"

module ZOrder
  BACKGROUND, PLAYER, ROCK, UI = *0..3
end

WINDOW_WIDTH = 800
WINDOW_HEIGHT= 600
FLOOR_HEIGHT = 75
GRAVITY      = 1

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
    @char_image  = Gosu::Image.new("graphics/character_1.png")
    @player      = @char_image.subimage(210,160,390,495)
    @hit_sound   = Gosu::Sample.new("sounds/hit_2.mp3")
    @floor       = 375
    @ceiling     = 125
    @x           = 300
    @y           = @floor
    @vel_x_left  = 8
    @vel_x_right = 8
    @velocity_y  = 0
    @jump_vel    = 26
    @gravity_vel = 1
    @vel_decrem  = 1
    @on_ground   = true
    @score       = 0
    @direction   = 0.3
  end

  def on_ground?
    @on_ground ? true : false
  end

  def move_right
    @x += @vel_x_right
    if @x > WINDOW_WIDTH - @player.width * 0.30
      @vel_x_right = 0
    else
      @vel_x_right = 8
    end
    @direction = -0.3
    @x + @player.width * 0.3
  end

  def move_left
    @x -= @vel_x_left
    if @x < 0
      @vel_x_left = 0
    else
      @vel_x_left = 8
    end
    @direction = 0.3
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
    scale_x = @direction == 0.3 ? 0.3:-0.3
    adjusted_scale_x = scale_x == -0.3 ? @x + @player.width * 0.3 : @x
    @player.draw adjusted_scale_x, @y, 0, scale_x, scale_y = 0.3
    # draw_border(@x, @y, @player.width * 0.3, @player.height * 0.3)
  end

  def gets_hit(rocks)
    rocks.reject! do |rock|
      if Gosu.distance(@x + @player.width/2 *0.3, @y + @player.height / 2 *0.3, rock.x, rock.y) < 80 #|| Gosu.distance(@x + 390, @y + 495,rock.x, rock.y) < 80
        @score -= 75
        @hit_sound.play
      else
        false
      end
    end

    def add_points(rocks)
      rocks.each do |rock|
        @score += 15 if rock.update_score?
      end
    end
  end

  # def draw_border(x, y, w, h)
  #   Gosu.draw_line(x, y, Gosu::Color::RED, x + w, y, Gosu::Color::RED, 1) #top border
  #   Gosu.draw_line(x + w, y, Gosu::Color::RED, x + w, y + h, Gosu::Color::RED, 1) #right border
  #   Gosu.draw_line(x + w, y + h, Gosu::Color::RED, x, y + h, Gosu::Color::RED, 1) #bottom border
  #   Gosu.draw_line(x, y + h, Gosu::Color::RED, x, y, Gosu::Color::RED, 1) #left border
  # end

  def game_over
    @score = 0
  end

  def you_win
    @score = 0
  end
end

class Rock
  attr_reader :x, :y
  def initialize(difficulty)
    @rock_image = Gosu::Image.new("graphics/rock.png")
    @rock       = @rock_image.subimage(148,170,300,262)
    @floor      = 540
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

  # def draw_border(x, y, w, h)
  #   Gosu.draw_line(x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15, Gosu::Color::RED, x - @rock.width/2 *0.15 + w, y - @rock.height/2 *0.15, Gosu::Color::RED, 1) #top border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15, Gosu::Color::RED, x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, 1) #right border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15 + w, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, 1) #bottom border
  #   Gosu.draw_line(x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15 + h, Gosu::Color::RED, x - @rock.width/2 * 0.15, y - @rock.height/2 *0.15, Gosu::Color::RED, 1) #left border
  # end

  def update_rock
    @x += @x_vel
    @y += @y_vel
    if @x < 0
      @x_vel = @vel
    elsif @x + @width > WINDOW_WIDTH
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
end


TITLE  = "Reflex Rush"

class Game < Gosu::Window
  def initialize(width = 800, height = 600)
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = TITLE

    @backgrounds = ["background_1", "background_2", "background_3",
                    "background_4", "background_5", "background_6",
                    "background_7", "background_8", "background_9",
                    "background_10", "background_11", "background_12",].map do |file|
                      Gosu::Image.new("graphics/#{file}.png")
                    end

    @level            = 1
    @background_level = 0
    @difficulty       = 4
    @floor            = Floor.new(0, WINDOW_HEIGHT - FLOOR_HEIGHT, WINDOW_WIDTH, FLOOR_HEIGHT)
    @player           = Player.new
    @rock             = Rock.new(@difficulty)
    @rocks            = [@rock]
    @last_generated   = Gosu.milliseconds
    @font             = Gosu::Font.new(20)
    @level_up_sound        = Gosu::Sample.new("sounds/level_up.mp3")
    @lose_sound       = Gosu::Sample.new("sounds/you_lose_sound.wav")
    @game_music       = Gosu::Sample.new("sounds/game_music.mp3")
    @score_background = Gosu::Image.new("graphics/score_background.png")
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
    @rocks.each do |rock|
      rock.update_rock
    end

    @player.gets_hit(@rocks)
    @player.add_points(@rocks)
    game_over
    you_win
  end

  def draw
    @backgrounds[@background_level].draw -21, 0, 0, 1.35, 1.35
    @player.draw
    if Gosu.milliseconds - @last_generated > 3_500
      @rocks << Rock.new(@difficulty)
      @last_generated = Gosu.milliseconds
    end
    @rocks.each do |rock|
      rock.draw
    end
    @score_background.draw 0, 550, 0, 1, 0.19, 0xBFffffff
    @font.draw_text("Score: #{@player.score}",130,565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @font.draw_text("Level: #{@level}", 20, 565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    @font.draw_text("Score 250 to advance", 600, 565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      close
    end
  end

  def you_win
    if @player.score >= 250
      @player.you_win
      @level_up_sound.play
      @rocks.clear
      @level += 1
      @background_level += 1
      @difficulty += 1
    end
  end

  def game_over
    if @player.score < 0
      @player.game_over
      @rocks.clear
      @lose_sound.play
      # @level = 1
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
