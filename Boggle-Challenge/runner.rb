require_relative 'boggle_board'
require_relative 'dice'


new_game = BoggleBoard.new
dice = Dice.new
puts new_game.to_s
puts "\n========\n\n"
puts "Let's start a new game!"
puts "\n========\n\n"
new_game.shake!
puts new_game.to_s
