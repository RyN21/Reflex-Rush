require 'gosu'
require_relative "main_menu"
require_relative "game_window"
# Handles switching between states

class StateManger
  def initialize(window)
    @window        = window
    @current_state = nil
  end

  def switch_to state
    @current_state = state
  end

  def update
    @current_state.update if @current_state
  end

  def draw
    @current_state.draw if @current_state
  end

  def button_down id
    @current_state.button_down id if @current_state
  end
end
