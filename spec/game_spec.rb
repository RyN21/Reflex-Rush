require 'spec_helper'

describe Game do
  let(:game) { Game.new }

  describe ".new" do
    it "returns a Game object" do
      expect(game).to be_an_instance_of Game
    end
  end
  describe ".updae" do
    it "text" do

    end
  end
  describe ".draw" do
    it "text" do

    end
  end
end

describe Sprite do

end
  # describe ".receive_input" do
  #   it "can take KB_ESCAPE and close" do
  #     # expect(input_manager.button_down keys[:escape]).to receive(:close)
  #     expect_any_instance_of(InputManager).to receive(:button_down)
  #     expect(game.receive_input keys[:escape]).to receive(:close)
  #   end
  # end
  #
  # describe ".draw" do
  # end
  # describe ".update" do
  # end
