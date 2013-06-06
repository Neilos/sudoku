require_relative 'cell'

class Board
attr_reader :cells

def initialize(puzzle_string, board_structure)
  @board_structure = board_structure
  @cells = []
  @not_finalized_cells_indexes = []
  initialize_cells(puzzle_string)
end

def deduce_all_cell_values!
  @cells.each_index {|position| deduce_cell_possiblities(position)}
end

def valid?
  @board_structure.rows.all? { |i| unique_values?(i) } &&
  @board_structure.columns.all? { |i| unique_values?(i) } &&
  @board_structure.boxes.all? { |i| unique_values?(i) }
end

def solved?
  valid? && fully_populated?
end

def solvable?
  @cells.all? {|cell| cell.possibilities.length > 0}
end

def to_s
  @cells.join
end

def create_copy
  Board.new(self.to_s, @board_structure)
end

#########################
private

def fully_populated?
  @cells.all? {|cell| cell.finalized?}
end

def initialize_cells(puzzle_string)
  puzzle_string.split('').each_with_index {|value, index| 
    cell = Cell.new(value, index)
    @cells << cell
    @not_finalized_cells_indexes << index unless cell.finalized? 
  }
end

def unique_values?(cell_positions)
  values = cell_positions.map{|i| cells[i].to_s} - ["0"]
  values.count == values.uniq.count
end

def deduce_cell_possiblities(position)
  unless @cells[position].finalized?
    aligned_positions = @board_structure.positions_aligned_with(position)
    impossible_values = aligned_positions.map { |position| @cells[position].to_s }
    @cells[position].subtract_from_possibilities(impossible_values)
  end
end

end