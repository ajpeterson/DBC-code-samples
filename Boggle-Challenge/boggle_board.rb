require_relative 'dice'

class BoggleBoard
  attr_accessor :board

  def initialize
    @board = new_board
    @dice = Dice.new

  end

  def new_board
    Array.new(4).map do |row|
      Array.new(4).map do |cell|
        cell = '_'
      end
    end
  end

  def shake!
    final_cell_values = @dice.generate_cell_values_from_dice

    @board.each do |row|
      row.each do |cell|
        cell.replace(final_cell_values.shift)
      end
    end
    @board
  end

  # Defining to_s on an object controls how the object is
  # represented as a string, e.g., when you pass it to puts
  def to_s
    output_board = ""
    @board.each do |row|
      each_row = row.join(' ')
      output_board << each_row + "\n"
    end
    output_board
  end

end
