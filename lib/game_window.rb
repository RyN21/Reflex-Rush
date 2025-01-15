require "gosu"
require_relative "player"
require_relative "rock"
require_relative "state_manager"
require_relative "main_menu"

#Game Logic and gameplay


class GameWindow

  def initialize(state_manager, difficulty)
    @state_manager = state_manager
    @difficulty    = difficulty
    @backgrounds   = ["background_1", "background_2", "background_3",
      "background_4", "background_5", "background_6",
      "background_7", "background_8", "background_9",
      "background_10", "background_11", "background_12",
      "background_13", "background_14", "background_15",
      "background_16", "background_17", "credit_page"].map do |file|
        Gosu::Image.new("graphics/#{file}.png")
      end

      @level            = 1
      @background_level = 0
      @player           = Player.new
      @rocks            = []
      @last_rock        = Gosu.milliseconds
      @font             = Gosu::Font.new(20)
      @score_background = Gosu::Image.new("graphics/score_background.png")
      @logo_bg          = Gosu::Image.new("graphics/logo_bg.png")
      @bonus_points        = []
      @last_bonus_Point     = Gosu.milliseconds
      @bonus_points_gen_time = 15_000

      @level_up_sound   = Gosu::Sample.new("sounds/level_up_2.mp3")
      @lose_sound       = Gosu::Sample.new("sounds/failed.mp3")
      @win_sound        = Gosu::Sample.new("sounds/you_won_sound.mp3")
      @game_music       = Gosu::Song.new("sounds/8bit_music.mp3")
      case @difficulty
      when 0
        @rock_velocity    = 2
        @gen_rock_time    = 7_000
        @score_to_advance = 45
      when 1
        @rock_velocity    = 3
        @gen_rock_time    = 5_000
        @score_to_advance = 60
      when 2
        @rock_velocity    = 4
        @gen_rock_time    = 3_000
        @score_to_advance = 75
      end
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
    @bonus_points.each do |bonus_point|
      bonus_point.update_bonus_point
    end

    # @bonus_points


    @player.gets_hit(@rocks)
    @player.bonus_point(@bonus_points)
    @player.add_points(@rocks)
    game_over
    level_up
    you_win
  end

  def draw
    if @background_level < @backgrounds.length - 1
      @backgrounds[@background_level].draw -21, 0, 0, 1.35, 1.35
      @player.draw
      if Gosu.milliseconds - @last_rock > @gen_rock_time
        @rocks << Rock.new(@rock_velocity)
        @last_rock = Gosu.milliseconds
      end
      @rocks.each do |rock|
        rock.draw
      end
      if Gosu.milliseconds - @last_bonus_Point > @bonus_points_gen_time
        @bonus_points << BonusPoint.new
        @last_bonus_Point = Gosu.milliseconds
      end
      @bonus_points.each do |bonus_point|
        bonus_point.draw
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
      @game_music.stop
      @state_manager.switch_to(MainMenu.new(@state_manager))
    end
  end

  def level_up
    if @player.score >= @score_to_advance && @background_level != @backgrounds.length - 1
      @background_level += 1
      @player.level_up
      @level_up_sound.play unless @background_level == @backgrounds.length - 1
      @level += 1
      @rocks.clear
      @rock_velocity += 1
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




# refactor
# window toggle
# add power ups
# health/lives
# character select option
# Visual effect for rock impact
#
# power up ideas
# increased speed
# gets smaller
# advance nect level
