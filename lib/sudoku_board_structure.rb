# assumes a list of numbered positions (indexes) in a grid and interprets this list as a grid, returning appropriate data Structures
class SudokuBoardStructure
attr_reader :board_width, :board_height, :box_width, :box_height

def initialize(dimensions={})
  @board_width = dimensions[:board_width] || 9
  @board_height = dimensions[:board_height] || 9
  @box_width = dimensions[:box_width] || 3
  @box_height = dimensions[:box_height] || 3
  validate_board_structure
  last_position = board_width * board_height - 1

  @positions_in_same_row_as = (0..last_position).map do |i|
      work_out_other_positions_in_same_row(i)
  end

  @positions_in_same_column_as = (0..last_position).map do |i|
      work_out_other_positions_in_same_column(i)
  end

  @positions_in_same_box_as = (0..last_position).map do |i|
    work_out_other_positions_in_same_box(i)
  end

end

def positions_in_same_row_as(position)
  @positions_in_same_row_as[position]
end

def positions_in_same_column_as(position)
  @positions_in_same_column_as[position]
end

def positions_in_same_box_as(position)
  @positions_in_same_box_as[position]
end

private

def validate_board_structure
  raise(RuntimeError, "invalid board dimensions") if (board_width % box_width != 0) || (board_height % box_height != 0)
end

###### POSITION FINDERS ######
def work_out_other_positions_in_same_row(position)
  position_in_row = position % board_width
  row_start = position - position_in_row
  (0..board_width-1).map { |i| row_start + i } - [position]
end

def work_out_other_positions_in_same_column(position)
  column_number = position % board_width
  (0..board_height-1).map { |i| 9 * i + column_number } - [position]
end

def work_out_other_positions_in_same_box(position)
  top_left = box_top_left_position(position)
  (0..2).map do |r|
    (0..2).map do |c| 
       top_left + r * 9 + c
    end
  end.flatten - [position]
end

def box_top_left_position(position)
  top_row = (position) / 9 / 3 * 3
  left_col = (position % 9) / 3 * 3
  start = top_row * 9 + left_col
end

end
