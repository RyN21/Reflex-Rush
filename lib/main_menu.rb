require 'gosu'
require_relative "state_manager"
require_relative "game_window"
# Main menu Logic
# module ZOrder
#   BACKGROUND, PLAYER, ROCK, UI = *0..3
# end
#
# WINDOW_WIDTH = 800
# WINDOW_HEIGHT= 600
# FLOOR        = 525
# TITLE        = "Reflex Rush"

class MainMenu
  def initialize state_manager
    @state_manager = state_manager
    @background    = Gosu::Image.new("graphics/background_14.png")
    @logo          = Gosu::Image.new("graphics/logo.png")
    @font          = Gosu::Font.new(30)
    @menu_music    = Gosu::Song.new("sounds/credits_music.mp3")
    @start_box     = Gosu::Image.new("graphics/score_background.png")
    @start_button_x      = 260
    @start_button_y      = 500
    @difficulty    = []
    @menu_music.play(true)
  end

  def update; end

  def draw
    @background.draw -21, 0, 0, 1.35, 1.35
    @logo.draw 175, -28, 0, 0.55, 0.55
    @start_box.draw @start_button_x, @start_button_y, 0, 0.3, 0.103
    @font.draw_text("Press ENTER to Start", @start_button_x + 15, @start_button_y + 3, 2, 1, 1)
  end

  def button_down id
    case id
    when Gosu::KB_ESCAPE
      exit
    when Gosu::KB_RETURN
      @menu_music.stop
      @state_manager.switch_to(GameWindow.new(@state_manager))
    end
  end
end
