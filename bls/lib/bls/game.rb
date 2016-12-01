require "bls/die"

class Game

  attr_reader :status

  def initialize(players, points_to_final=3000)
    @players = players
    @dice = Array.new(5) {Die.new}
    @status = 'not_started'
    @points_to_final = points_to_final

  end

  def start()
    if @players.length > 1
      @status = 'started'
      #game_process
    else
      false
    end
  end

  def game_process()
    while @status != 'finished' do

      for player in @players

        @status = 'finished'
        @dice = Array.new(5) {Die.new}
        if player.points >= 3000
          @status = 'finished'
        end
      end
    end
  end

  def join_player(player)
    @players << player
  end

end
