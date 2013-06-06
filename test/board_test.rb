require 'minitest/spec'
require 'minitest/autorun'
require '../lib/board'
require '../lib/sudoku_board_structure'


describe Board do
  before do
    @puzzle_string = "940170058020006090175090304308000600010802900500934007009740580604005100000080023"
    @solution_string = "946173258823456791175298364398517642417862935562934817239741586684325179751689423"
    @board_structure = SudokuBoardStructure.new
    @board = Board.new(@puzzle_string, @board_structure)
  end

  it "should have a collection of cells" do
    @board.cells.must_be_instance_of Array
  end

  it "can return a string of the values of its cells" do
    @board.to_s.must_equal @puzzle_string
  end

  it "can create copies of itself" do
    @board.create_copy.must_be_instance_of Board
    @board.create_copy.to_s.must_equal @board.to_s
  end

  it "should deduce_cell_possiblities for all cells" do
    partial_solution_string = "940173258823056791175298364398517642010862935562934817239741586684325179751689423"
    @board.deduce_all_cell_values!
    @board.to_s.must_equal partial_solution_string
  end

  it "should be 'solvable' as long as all cells have at least one possible value" do
    solvable_board = @board
    solvable_board.solvable?.must_equal true
  end

  it "should NOT be 'solvable' if the cells don't have at least one possible value" do
    unsolved_puzzle_string = "096173258823456791175298364398517642417862935562934817239741586684325179751689423"
    unsolved_board = Board.new(unsolved_puzzle_string, @board_structure)
    unsolved_board.deduce_all_cell_values!
    unsolved_board.solvable?.wont_equal true
  end

  it "should know when it is fully_populated" do
    fully_populated_invalid_board_string = (1..9).to_a.join * 9
    fully_populated_board = Board.new(fully_populated_invalid_board_string, @board_structure)
    fully_populated_board.send(:fully_populated?).must_equal true
  end

  it "should be valid when there are no duplicate values in all rows columns and boxes" do
    invalid_board_string = (1..9).to_a.join * 9
    invalid_board = Board.new(invalid_board_string, @board_structure)
    invalid_board.valid?.must_equal false

    valid_board_string = @puzzle_string
    valid_board = Board.new(valid_board_string, @board_structure)
    valid_board.valid?.must_equal true
  end

  it "should only be solved when fully_populated and valid" do
    solved_puzzle_string = "946173258823456791175298364398517642417862935562934817239741586684325179751689423"
    solved_board = Board.new(solved_puzzle_string, @board_structure)
    solved_board.valid?.must_equal true
    solved_board.send(:fully_populated?).must_equal true
    solved_board.solved?.must_equal true

    invalid_board_string = (1..9).to_a.join * 9
    invalid_board = Board.new(invalid_board_string, @board_structure)
    invalid_board.valid?.must_equal false
    invalid_board.solved?.must_equal false

    fully_populated_invalid_board_string = (1..9).to_a.join * 9
    fully_populated_board = Board.new(fully_populated_invalid_board_string, @board_structure)
    fully_populated_board.send(:fully_populated?).must_equal true
    fully_populated_board.solved?.must_equal false
  end

end
