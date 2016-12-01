require "bls/game"
require "bls/player"

describe Game do
  before(:each) do
    @player1 = Player.new("John")
    @player2 = Player.new("Peter")
  end

  it 'is not able to start' do
    game = Game.new([@player1])
    expect(game.start()).to eq(false)
  end

  it 'is able to start' do
    game = Game.new([@player1, @player2])
    game.start()
    expect(game.status).to eq('started')
  end
end
