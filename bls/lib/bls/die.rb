#  Definition of class Die
class Die
 attr_accessor :value, :is_scoring, :can_be_scoring

 def initialize()
   @value = nil
   @is_scoring = false
   @can_be_scoring = false
 end

 # Roll the die
 def roll(value=nil)
   @value = value != nil ? value : rand(1..6)
 end

 # Restet die to their initialize state
 def reset()
   @value = nil
   @is_scoring = false
   @can_be_scoring = false
 end
end
