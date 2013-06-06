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

it "should know the positions in a given row" do
  @board_structure.rows.must_equal [[0, 1, 2, 3, 4, 5, 6, 7, 8], [9, 10, 11, 12, 13, 14, 15, 16, 17], [18, 19, 20, 21, 22, 23, 24, 25, 26], [27, 28, 29, 30, 31, 32, 33, 34, 35], [36, 37, 38, 39, 40, 41, 42, 43, 44], [45, 46, 47, 48, 49, 50, 51, 52, 53], [54, 55, 56, 57, 58, 59, 60, 61, 62], [63, 64, 65, 66, 67, 68, 69, 70, 71], [72, 73, 74, 75, 76, 77, 78, 79, 80]]
end

it "should the positions in a given column" do
  @board_structure.columns.must_equal [[0, 9, 18, 27, 36, 45, 54, 63, 72], [1, 10, 19, 28, 37, 46, 55, 64, 73], [2, 11, 20, 29, 38, 47, 56, 65, 74], [3, 12, 21, 30, 39, 48, 57, 66, 75], [4, 13, 22, 31, 40, 49, 58, 67, 76], [5, 14, 23, 32, 41, 50, 59, 68, 77], [6, 15, 24, 33, 42, 51, 60, 69, 78], [7, 16, 25, 34, 43, 52, 61, 70, 79], [8, 17, 26, 35, 44, 53, 62, 71, 80]]
end

it "should the positions in a given box" do
  @board_structure.boxes.must_equal [[0, 1, 2, 9, 10, 11, 18, 19, 20], [3, 4, 5, 12, 13, 14, 21, 22, 23], [6, 7, 8, 15, 16, 17, 24, 25, 26], [27, 28, 29, 36, 37, 38, 45, 46, 47], [30, 31, 32, 39, 40, 41, 48, 49, 50], [33, 34, 35, 42, 43, 44, 51, 52, 53], [54, 55, 56, 63, 64, 65, 72, 73, 74], [57, 58, 59, 66, 67, 68, 75, 76, 77], [60, 61, 62, 69, 70, 71, 78, 79, 80]]
end



describe "private methods" do

  it "should work out other positions aligned with a specified position" do
    row_positions = @board_structure.send(:work_out_other_positions_in_same_row,23)
    column_positions = @board_structure.send(:work_out_other_positions_in_same_column,23)
    box_positions = @board_structure.send(:work_out_other_positions_in_same_box,23)
    
    expected = row_positions + column_positions + box_positions

    @board_structure.send(:work_out_other_positions_aligned_with,23).must_equal expected.uniq
  end

  it "should work out other positions in the same row" do
    @board_structure.send(:work_out_other_positions_in_same_row,4).must_equal [0,1,2,3,5,6,7,8]
  end

  it "should work out other positions in the same col" do
    @board_structure.send(:work_out_other_positions_in_same_column,13).must_equal [4,22,31,40,49,58,67,76]
  end

  it "should find other positions in the same box" do
    @board_structure.send(:work_out_other_positions_in_same_box,22).must_equal [3,4,5,12,13,14,21,23]
  end

  describe "box_top_left_position" do
    answers = [0,0,0,3,3,3,6,6,6,
               0,0,0,3,3,3,6,6,6,
               0,0,0,3,3,3,6,6,6,
               27,27,27,30,30,30,33,33,33,
               27,27,27,30,30,30,33,33,33,               
               27,27,27,30,30,30,33,33,33,
               54,54,54,57,57,57,60,60,60, 
               54,54,54,57,57,57,60,60,60,
               54,54,54,57,57,57,60,60,60]
    (0..80).each do |i| 

      it "should work out the position of the top left corner of the box containing the index: #{i}" do 
        @board_structure.send(:box_top_left_position, i).must_equal answers[i] 
      end
    
    end
  end
end

end