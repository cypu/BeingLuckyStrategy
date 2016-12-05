require "bls/die"

class Game

  attr_reader :dice
  attr_accessor :players, :status

  def initialize(players, points_hash, points_to_final=3000)
    @players = players
    @dice = Array.new(5) {Die.new}
    @status = 'not_started'
    @points_to_final = points_to_final
    @points_hash = points_hash
  end

  def start()
    if @players.length > 1
      @status = 'started'
    else
      false
    end
  end

  def calc_points_for_dice
    total = 0
    for d in @dice
      total += calc_points
    end
    total
  end

  def reset_can_be_scored_dice
      for d in @dice.select { |x| x.can_be_scoring == true && x.is_scoring == false }
        d.can_be_scoring = false
      end
  end

  def set_can_be_scoring_to_scoring
    for d in @dice.select {|x| x.can_be_scoring == true }
      d.is_scoring = true
    end
  end

  def calc_points()
    points = 0
    @points_hash.each do |key, val|
      key_len = key.to_s.length # number of dice needed to get a score

      key.to_s.split('').each do |i|
        for d in @dice.select { |x| x.can_be_scoring == false && x.is_scoring == false }
          if d.value == i.to_i
            d.can_be_scoring = true
            key_len -= 1
            break
          end
        end

      if key_len == 0
        set_can_be_scoring_to_scoring
        points += val
      end

      end
      reset_can_be_scored_dice
    end
    points
  end

  def turn(player_index)
    player = @players[player_index]
    # while player.can_roll_again
      player.throw_dice(@dice)
      points = calc_points_for_dice
      player.accumulate_points(points)
      reset_dice
      if player.points >= 3000
        @status = 'final'
      end
    # end
    @players[player_index] = player
  end

  def join_player(player)
    @players << player
  end

  def reset_dice
    @dice.each_with_index do |die, index|
      @dice[index].reset
    end
  end

  private :reset_can_be_scored_dice, :set_can_be_scoring_to_scoring, :reset_dice

end
