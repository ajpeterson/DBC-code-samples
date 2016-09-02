class Dice
  attr_reader :dice

  def initialize
    @dice = dice_array
  end

  def dice_array
    [
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
      ['H', 'I', 'M', 'N', 'Q', 'U'],
      ['E', 'E', 'I', 'N', 'S', 'U'],
      ['E', 'E', 'G', 'H', 'N', 'W'],
      ['A', 'F', 'F', 'K', 'P', 'S'],
      ['H', 'L', 'N', 'N', 'R', 'Z'],
      ['D', 'E', 'I', 'L', 'R', 'X']
    ]
  end

  def roll(die_to_roll)
    die_to_roll.sample
  end

  def generate_cell_values_from_dice
    cell_values_for_new_game = []
    @dice.shuffle.each do |die|
      cell_values_for_new_game << roll(die)
    end
    substitue_for_q(cell_values_for_new_game)
  end

  def substitue_for_q(dice_values)
    dice_values.map do |die_letter|
      if die_letter == 'Q'
        die_letter = 'Qu'
      else
        die_letter + ' '
      end
    end
  end
end
