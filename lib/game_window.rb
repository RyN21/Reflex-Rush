require "gosu"
require_relative "player"
require_relative "rock"

#Game Logic and gameplay

module ZOrder
  BACKGROUND, PLAYER, ROCK, UI = *0..3
end

WINDOW_WIDTH = 800
WINDOW_HEIGHT= 600
FLOOR        = 525
TITLE        = "Reflex Rush"

class GameWindow < Gosu::Window
  def initialize(width = 800, height = 600)
    super(WINDOW_WIDTH, WINDOW_HEIGHT)
    self.caption = TITLE
    start
  end

  def start
    @backgrounds = ["background_1", "background_2", "background_3",
      "background_4", "background_5", "background_6",
      "background_7", "background_8", "background_9",
      "background_10", "background_11", "background_12",
      "background_13", "background_14", "background_15",
      "background_16", "background_17", "credit_page"].map do |file|
        Gosu::Image.new("graphics/#{file}.png")
      end

      @level            = 1
      @background_level = 0
      @difficulty       = 3
      @score_to_advance = 60
      @player           = Player.new
      @rocks            = []
      @last_rock        = Gosu.milliseconds
      @font             = Gosu::Font.new(20)
      @score_background = Gosu::Image.new("graphics/score_background.png")
      @logo_bg          = Gosu::Image.new("graphics/logo_bg.png")
      @power_ups        = []

      @level_up_sound   = Gosu::Sample.new("sounds/level_up_2.mp3")
      @lose_sound       = Gosu::Sample.new("sounds/failed.mp3")
      @win_sound        = Gosu::Sample.new("sounds/you_won_sound.mp3")
      @game_music       = Gosu::Song.new("sounds/8bit_music.mp3")
      @credits_music    = Gosu::Song.new("sounds/credits_music.mp3")
  end

  def reset
    start
  end

  def update
    @game_music.play(true) unless @game_music.playing?
    if @player.victory?(@level, @backgrounds)
      @credits_music.play(true) unless @credits_music.playing?
    end
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
    # @player.power_up(@power_ups)
    @player.add_points(@rocks)
    game_over
    level_up
    you_win
  end

  def draw
    if @background_level < @backgrounds.length - 1
      @backgrounds[@background_level].draw -21, 0, 0, 1.35, 1.35
      @player.draw
      if Gosu.milliseconds - @last_rock > 4_000
        @rocks << Rock.new(@difficulty)
        @last_rock = Gosu.milliseconds
      end
      @rocks.each do |rock|
        rock.draw
      end

      @score_background.draw 0, 550, 0, 1, 0.19, 0xBFffffff
      @font.draw_text("Score: #{@player.score}",130,565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw_text("Level: #{@level}/#{@backgrounds.length-1}", 20, 565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
      @font.draw_text("Score #{@score_to_advance} to advance", 600, 565, ZOrder::UI, 1.0, 1.0, Gosu::Color::YELLOW)
    else
      @backgrounds[@background_level].draw 19, 33, 0, 0.95, 0.95
      @score_background.draw 0, 550, 0, 1, 0.19, 0xBFffffff
    end
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      close
    when Gosu::KB_RETURN
      reset
    end
  end

  def level_up
    if @player.score >= @score_to_advance && @background_level != @backgrounds.length - 1
      @background_level += 1
      @player.level_up
      @level_up_sound.play unless @background_level == @backgrounds.length - 1
      @level += 1
      @rocks.clear
      @difficulty += 1
      @score_to_advance += 15
    end
  end

  def game_over
    if @player.score < 0
      @player.game_over
      @rocks.clear
      @lose_sound.play
    end
  end

  def you_win
    if @player.victory?(@level, @backgrounds)
      @win_sound.play
      @level += 1
    end
  end
end

GameWindow.new.show




# refactor
# window toggle
# add power ups
# health
# add menu section
  # pick character
  # pick difficulty
