require "bls/game"
require "bls/player"
require "pp"

describe Game do
  before(:each) do
    @player1 = Player.new("John")
    @player2 = Player.new("Peter")
    @points_hash = {
      '111': 1000,
      '222': 200,
      '333': 300,
      '444': 400,
      '555': 500,
      '666': 600,
      '1': 100,
      '5': 50
    }
    @dice = Array.new(5) {Die.new}
    @player1.throw_dice(@dice)
  end

  it 'is not able to start' do
    game = Game.new([@player1], @points_hash)
    expect(game.start()).to eq(false)
  end

  it 'is able to start' do
    game = Game.new([@player1, @player2], @points_hash)
    game.start()
    expect(game.status).to eq('started')
  end

  it 'counts points correctly' do
    game = Game.new([@player1, @player2], @points_hash)
    game.players[0].throw_dice(game.dice)
    game.calc_points_for_dice
  end
end
