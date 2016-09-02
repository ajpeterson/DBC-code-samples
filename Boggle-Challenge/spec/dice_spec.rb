require_relative '../boggle_board'
require_relative '../dice'

describe "Dice class" do

  let(:board) { BoggleBoard.new }
  let(:dice) { Dice.new }
  let(:rolled_dice) { ['A', 'O', 'O', 'T', 'T', 'W'] }

  it "contains 16 dice" do
    expect(dice.dice_array.length).to eq(16)
  end

  it "has 6 possible values for each dice" do
    expect(dice.dice_array[rand(0..15)].length).to eq(6)
  end

  it 'returns one of a possible six values' do
    expect(rolled_dice).to include(dice.roll(rolled_dice))
  end

  it 'returns an array representing 16 values' do
    expect(dice.generate_cell_values_from_dice.length).to be(16)
  end
end
