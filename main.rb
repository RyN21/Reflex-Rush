Dir[File.join(File.dirname(__FILE__), "lib", "**.rb")].each do |file|
  require file
end

# Entry Point for game

require "gosu"
require_relative "lib/state_manager"
require_relative "lib/main_menu"
require_relative "lib/game_window"

module ZOrder
  BACKGROUND, PLAYER, ROCK, UI = *0..3
end

WINDOW_WIDTH = 800
WINDOW_HEIGHT= 600
FLOOR        = 525
TITLE        = "Reflex Rush"

class Main < Gosu::Window
  def initialize
    super WINDOW_WIDTH, WINDOW_HEIGHT
    self.caption = TITLE
    @state_manager = StateManger.new(self)

    @state_manager.switch_to(MainMenu.new(@state_manager))
  end

  def update
    @state_manager.update
  end

  def draw
    @state_manager.draw
  end

  def button_down id
    @state_manager.button_down id
  end
end

Main.new.show






# Game.setup
# WindowGame.start
