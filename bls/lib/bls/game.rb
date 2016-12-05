require "bls/die"

# This class provides ability to create and play game Being Lucky
class Game

  attr_reader :dice
  attr_accessor :players, :status

  def initialize(points_hash, points_to_final: 3000, accumulate_band: 300, players: [])
    @players = players
    @dice = Array.new(5) {Die.new}
    @status = 'not_started'
    @points_to_final = points_to_final
    @points_hash = points_hash
    @accumulate_band = accumulate_band
  end

  # Starts the game
  def start()
    if @players.length > 1
      @status = 'started'
    else
      false
    end
  end

  # Calculate the score for dice values
  def calc_points_for_dice
    total = 0
    for d in @dice
      total += points_inspection
    end
    total
  end

  # Set dice property can_be_scoring to fasle
  def reset_can_be_scored_dice
      for d in @dice.select { |x| x.can_be_scoring == true && x.is_scoring == false }
        d.can_be_scoring = false
      end
  end

  # Set dice property is_scoring to true for all dice that can be scoring
  def set_can_be_scoring_to_scoring
    for d in @dice.select { |x| x.can_be_scoring == true }
      d.is_scoring = true
    end
  end

  # Match the element of points_hash to values on dice
  def points_inspection()
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

  # Defines algorithm of player's turn in the game
  def turn(player_index)
    player = @players[player_index]
    turn_points = 0
    while player.can_roll_again == true do
      player.throw_dice(@dice)
      throw_points = calc_points_for_dice
      if throw_points == 0 # when user throw again and get 0 points then it looses all points
        turn_points = 0
        break
      end
      turn_points += throw_points
      player.can_roll_again = turn_points == 0 ? false : player.throw_again
    end
    if !player.can_accumulate && turn_points >= @accumulate_band
      player.can_accumulate = true
    end
    player.accumulate_points(turn_points)
    if player.points >= @points_to_final
      @status = 'final'
    end
    reset_dice
    player.can_roll_again = true
    @players[player_index] = player
  end

  # Restet dice to their initialize state
  def reset_dice
    @dice.each_with_index do |die, index|
      @dice[index].reset
    end
  end

  # Join player to the game
  def join_player(player)
    @players << player
  end

  private :reset_can_be_scored_dice, :set_can_be_scoring_to_scoring, :reset_dice,
          :points_inspection

end
