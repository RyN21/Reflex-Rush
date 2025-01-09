require "gosu"

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
