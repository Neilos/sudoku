# assumes returns appropriate data Structures for a board with given dimensions
class SudokuBoardStructure
  attr_reader :board_width, :board_height, :box_width, :box_height, :rows, :columns, :boxes

  def initialize(dimensions={})
    @board_width = dimensions[:board_width] || 9
    @board_height = dimensions[:board_height] || 9
    @box_width = dimensions[:box_width] || 3
    @box_height = dimensions[:box_height] || 3
    validate_board_structure
    last_position = board_width * board_height - 1

    @positions_aligned_with = (0..last_position).map { |i| work_out_other_positions_aligned_with(i) }

    @rows = work_out_rows
    @columns = work_out_columns
    @boxes = work_out_boxes
  end

  def positions_aligned_with(position)
    @positions_aligned_with[position]
  end


private

  def validate_board_structure
    raise(RuntimeError, "invalid board dimensions") if (board_width % box_width != 0) || (board_height % box_height != 0)
  end


  def work_out_rows
    @rows = (0..board_height-1).map do |j|
      (0..board_width-1).map{|i| j * board_width + i}
    end
  end

  def work_out_columns
    @columns = (0..board_height-1).map do |j|
      (0..board_width-1).map{|i| j + board_width * i}
    end
  end

  def work_out_boxes
    boxes = []
    (0..(board_width / box_width)-1).each do |a|
      (0..(board_height / box_height)-1).each do |b|
        boxes << (0..box_height-1).map do |j|
          (0..box_width-1).map  do |i|
             (i + j * board_width + b * box_width + a * board_width * box_height)
          end
        end.flatten
      end
    end
    boxes
  end

  def work_out_other_positions_aligned_with(position)
    result = (work_out_other_positions_in_same_row(position) + work_out_other_positions_in_same_column(position) + work_out_other_positions_in_same_box(position)  - [position]).uniq
  end

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
    top_row = position / board_width / 3 * 3
    left_col = (position % board_width) / 3 * 3
    start = top_row * board_width + left_col
  end
end
