class GameDie
  attr_reader :value

  def initialize(sides)
    @sides = sides
  end

  def shake!
    @value = @sides.sample
  end

  def to_s
    "Showing #{@value} (from #{@sides})"
  end
end

class GameDice
  attr_reader :dice

  DICE_VALUES = [
    ['A', 'A', 'E', 'E', 'G', 'N'],
    ['E', 'L', 'R', 'T', 'T', 'Y'],
    ['A', 'O', 'O', 'T', 'T', 'W'],
    ['A', 'B', 'B', 'J', 'O', 'O'],
    ['E', 'H', 'R', 'T', 'V', 'W'],
    ['C', 'I', 'M', 'O', 'T', 'U'],
    ['D', 'I', 'S', 'T', 'T', 'Y'],
    ['E', 'I', 'O', 'S', 'S', 'T'],
    ['D', 'E', 'L', 'R', 'V', 'Y'],
    ['A', 'C', 'H', 'O', 'P', 'S'],
    ['H', 'I', 'M', 'N', 'Qu', 'U'],
    ['E', 'E', 'I', 'N', 'S', 'U'],
    ['E', 'E', 'G', 'H', 'N', 'W'],
    ['A', 'F', 'F', 'K', 'P', 'S'],
    ['H', 'L', 'N', 'N', 'R', 'Z'],
    ['D', 'E', 'I', 'L', 'R', 'X']
  ]

  def initialize
    @dice = DICE_VALUES.map { |sides| GameDie.new(sides) }
    shake!
  end

  def shake!
    @dice.shuffle!

    @dice.each do |die|
      die.shake!
    end
  end

  def format_value_to_s(value)
  	value + (value  == 'Qu' ? ' ' : '  ')
  end

  def to_s
  	output = []
  	output << "-" * 15
  		output << "\n"

  	@dice.each_slice(4) do |row|
  		output << '| '
  		# row is an array of 4 GameDie
  		row.each do |die|
  			output << format_value_to_s(die.value)
  		end
  		output << "|\n"
  	end

  	output << "-" * 15

  	output.join("")
  end
end

gameDice = GameDice.new

puts gameDice
