#  definition of class Die

class Die
 attr_accessor :value, :is_scoring, :can_be_scoring

 def initialize()
   @value = nil
   @is_scoring = false
   @can_be_scoring = false
 end

 # method responsible for dice roling
 def roll()
   @value = rand(1..6)
 end

 def reset()
   @value = nil
   @is_scoring = false
   @can_be_scoring = false
 end
end
