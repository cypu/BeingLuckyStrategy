#  definition of class Die
class Die
 attr_accessor :value, :is_scoring
 #attr_reader :is_scoring
 def initialize()
   @value = nil
   @is_scoring = false
 end

 # method responsible for dice roling
 def roll()
   @value = rand(1..6)
 end
end
