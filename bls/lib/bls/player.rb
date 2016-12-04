
class Player

  attr_accessor :can_accumulate
  attr_reader :points, :name

  def initialize(name='')
    @name = name
    @points = 0
    @can_accumulate = false
  end

  def accumulate_points(points)
    if points >= 300
      @can_accumulate = true
    end

    if @can_accumulate
      @points += points
    end
  end

  def throw_dice(dice)
    for d in dice
      d.roll()
    end
  end

  def throw_again()
    [false,true].sample
  end

end
