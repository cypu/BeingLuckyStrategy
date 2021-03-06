$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bls/game'
require 'bls/player'
require 'pp'

if __FILE__ == $0

  player1 = Player.new("John")
  player2 = Player.new("Peter")
  player3 = Player.new("Kinga")
  points_hash = {
    '111': 1000,
    '222': 200,
    '333': 300,
    '444': 400,
    '555': 500,
    '666': 600,
    '1': 100,
    '5': 50
  }
  dice = Array.new(5) {Die.new}

  game = Game.new(points_hash, players: [player1, player2])
  game.start

  if game.start
    while game.status != 'final' do
      game.players.each_with_index do |player, index|
        game.turn(index)
        if game.status == 'final'
          break
        end
      end
    end

    # final round
    game.players.each_with_index do |player, index|
      game.turn(index)
    end
  else
    puts "You need more players to start the game"
  end

  pp game.players

end
