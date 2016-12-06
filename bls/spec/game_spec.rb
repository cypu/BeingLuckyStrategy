require "bls/game"
require "bls/player"

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
  end

  it 'is not able to start' do
    game = Game.new(@points_hash, players: [@player1])
    expect(game.start()).to eq(false)
  end

  it 'is able to start' do
    game = Game.new(@points_hash, players: [@player1, @player2])
    expect(game.start()).to eq(true)
    expect(game.status).to eq('started')
  end

  it 'can join new player to the game' do
    game = Game.new(@points_hash, players: [@player1, @player2])
    new_player = Player.new("New player")
    game.join_player(new_player)
    expect(game.players.length).to eq(3)
  end

  it 'counts points correctly (maximum value)' do
    dice_values = [1,1,5,1,1]
    game = Game.new(@points_hash, players: [@player1, @player2])
    #set dice values manualy to check score
    game.dice.each_with_index do |value, index|
      game.dice[index].roll(dice_values[index])
    end
    expect(game.calc_points_for_dice).to eq(1150)
  end

  it 'counts points correctly (minimum value)' do
    dice_values = [1,2,3,4,5]
    game = Game.new(@points_hash, players: [@player1, @player2])
    game.dice.each_with_index do |value, index|
      game.dice[index].roll(dice_values[index])
    end
    expect(game.calc_points_for_dice).to eq(150)
  end

  it 'counts points correctly (no value)' do
    dice_values = [2,3,2,6,3]
    game = Game.new(@points_hash, players: [@player1, @player2])
    game.dice.each_with_index do |value, index|
      game.dice[index].roll(dice_values[index])
    end
    expect(game.calc_points_for_dice).to eq(0)
  end

  it 'can reset dice' do
    game = Game.new(@points_hash, players: [@player1, @player2])
    game.send :reset_dice
    game.dice.each do |die|
      expect(die.value).to eq(nil)
      expect(die.is_scoring).to eq(false)
      expect(die.can_be_scoring).to eq(false)
    end
  end

end
