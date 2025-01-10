require 'gosu'
require_relative "state_manager"
require_relative "game_window"
# Main menu Logic

class MainMenu
  DIFFICULTIES = ["Easy", "Normal   ", "   Hard"]

  def initialize state_manager
    @state_manager  = state_manager
    @background     = Gosu::Image.new("graphics/background_14.png")
    @logo           = Gosu::Image.new("graphics/logo.png")
    @font           = Gosu::Font.new(30)
    @menu_music     = Gosu::Song.new("sounds/credits_music.mp3")
    @start_box      = Gosu::Image.new("graphics/score_background.png")
    @difficulty_y   = 300
    @start_button_x = 260
    @start_button_y = 500
    @difficulty_sel = 1
    @menu_music.play(true)
  end

  def update; end

  def draw
    @background.draw -21, 0, 0, 1.35, 1.35
    @logo.draw 175, -28, 0, 0.55, 0.55
    @start_box.draw 185, 430, 0, 0.45, 0.103
    @start_box.draw @start_button_x, 395, 0, 0.3, 0.103
    @font.draw_text("Select Difficulty", @start_button_x + 50, 395, 2, 1, 1)
    DIFFICULTIES.each_with_index do |diff, index|
      color = index == @difficulty_sel ? Gosu::Color::GREEN : Gosu::Color::WHITE
      @font.draw_text(diff, 233 + (index * 125), 430, 1, 1, 1, color)
    end
    @start_box.draw @start_button_x, @start_button_y, 0, 0.3, 0.103
    @font.draw_text("Press ENTER to Start", @start_button_x + 15, @start_button_y + 3, 2, 1, 1)
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      exit
    when Gosu::KB_RETURN
      @menu_music.stop
      @state_manager.switch_to(GameWindow.new(@state_manager, @difficulty_sel))
    when Gosu::KB_LEFT
      @difficulty_sel = (@difficulty_sel - 1) % DIFFICULTIES.size
    when Gosu::KB_RIGHT
      @difficulty_sel = (@difficulty_sel + 1) % DIFFICULTIES.size
    end
  end
end
