# Definition of class Player
class Player

  attr_accessor :can_accumulate, :can_roll_again
  attr_reader :points, :name

  def initialize(name='')
    @name = name
    @points = 0
    @can_accumulate = false
    @can_roll_again = true
  end

  # Accumulate points
  def accumulate_points(points)
    if @can_accumulate
      @points += points
      return
    end
  end

  # Throwing dice action
  def throw_dice(dice, values=nil)
    if values != nil
      values.each_with_index do |val, index|
        dice[index].roll(val)
      end
    else
      for d in dice.select { |x| x.can_be_scoring == false && x.is_scoring == false }
        d.roll()
      end
    end
  end

  # Make a decision if throw dice again in turn
  def throw_again()
    [false,true].sample
  end

end
