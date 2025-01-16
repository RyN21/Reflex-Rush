require "gosu"

class Credits
  def initialize state_manager, result
    @state_manager = state_manager
    @result        = result
    @credit_win    = Gosu::Image.new("graphics/credit_page.png")
    @credit_lose   = Gosu::Image.new("graphics/credit_lose.png")

  end

  def update; end

  def draw
    if @result == "win"
      @credit_win.draw 0, 0, 0, 1, 1
    elsif  @result == "lost"
      @credit_lose.draw 0, 0, 0, 1, 1
    end
  end

  def button_down id
    case id
    when Gosu::KB_RETURN || Gosu::KB_ESCAPE
        @state_manager.switch_to(MainMenu.new(@state_manager))
    end
  end
end
