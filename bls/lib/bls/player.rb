
class Player

  attr_accessor :can_accumulate, :can_roll_again
  attr_reader :points, :name

  def initialize(name='')
    @name = name
    @points = 0
    @can_accumulate = false
    @can_roll_again = true
  end

  def accumulate_points(points)
    if @can_accumulate
      @points += points
      return
    end
    if points >= 300
      @can_accumulate = true
    end
  end

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

  def throw_again()
    [false,true].sample
  end

end
