require 'minitest/spec'
require 'minitest/autorun'
require '../lib/sudoku_board_structure'

describe SudokuBoardStructure do

before do
  @board_structure = SudokuBoardStructure.new()
end

it "should have a default board_width, board_height, box_width, box_height" do
  @board_structure.send(:board_width).must_equal 9
  @board_structure.send(:board_height).must_equal 9
  @board_structure.send(:box_width).must_equal 3
  @board_structure.send(:box_height).must_equal 3
end

it "should complain if the sudoku board structure is invalid" do
  lambda do
    @invalid_board_structure = SudokuBoardStructure.new(board_width:8, box_width:3)
  end.must_raise RuntimeError
end

it "should know the other positions aligned with a specified position" do
  @board_structure.positions_aligned_with(23).must_equal [18, 19, 20, 21, 22, 24, 25, 26, 5, 14, 32, 41, 50, 59, 68, 77, 3, 4, 12, 13]
end


# describe "private methods" do
#   it "should work out other positions aligned with a specified position" do
#     row_positions = @board_structure.send(:work_out_other_positions_in_same_row,23)
#     column_positions = @board_structure.send(:work_out_other_positions_in_same_column,23)
#     box_positions = @board_structure.send(:work_out_other_positions_in_same_box,23)
    
#     expected = row_positions + column_positions + box_positions

#     @board_structure.send(:work_out_other_positions_aligned_with,23).must_equal expected.uniq
#   end

#   it "should work out other positions in the same row" do
#     @board_structure.send(:work_out_other_positions_in_same_row,4).must_equal [0,1,2,3,5,6,7,8]
#   end

#   it "should work out other positions in the same col" do
#     @board_structure.send(:work_out_other_positions_in_same_column,13).must_equal [4,22,31,40,49,58,67,76]
#   end

#   it "should find other positions in the same box" do
#     @board_structure.send(:work_out_other_positions_in_same_box,22).must_equal [3,4,5,12,13,14,21,23]
#   end

#   describe "box_top_left_position" do
#     answers = [0,0,0,3,3,3,6,6,6,
#                0,0,0,3,3,3,6,6,6,
#                0,0,0,3,3,3,6,6,6,
#                27,27,27,30,30,30,33,33,33,
#                27,27,27,30,30,30,33,33,33,               
#                27,27,27,30,30,30,33,33,33,
#                54,54,54,57,57,57,60,60,60, 
#                54,54,54,57,57,57,60,60,60,
#                54,54,54,57,57,57,60,60,60]
#     (0..80).each do |i| 

#       it "should work out the position of the top left corner of the box containing the index: #{i}" do 
#         @board_structure.send(:box_top_left_position, i).must_equal answers[i] 
#       end
    
#     end
#   end
# end

end