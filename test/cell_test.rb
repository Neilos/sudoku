
require 'minitest/spec'
require 'minitest/autorun'
require '../lib/cell'

describe Cell do
  before do
    @finalized_cell = Cell.new("2")
    @non_finalized_cell = Cell.new("0")
  end

  it "should have possible values" do
    @finalized_cell.must_respond_to :possible_values
    @finalized_cell.must_respond_to :possible_values=
    @finalized_cell.possible_values.must_be_instance_of Array
  end

  it "should have an array of possible values from 1 to 9 when the initialized value is 0" do
    @non_finalized_cell.possible_values.must_equal ["1","2","3","4","5","6","7","8","9"]
  end

  describe "subtract_from_possible_values method" do
    it "should accept an array of numbers and remove the numbers in those arrays from the array of possible_values" do
      array = ["1","2","3","4","4","5","6"]
      @non_finalized_cell.subtract_from_possible_values(array).must_equal ["7","8","9"]
      @non_finalized_cell.possible_values.must_equal ["7","8","9"]
    end
  end

  it "should be finalized if it has only one possible value" do
    @finalized_cell.possible_values.count.must_equal 1
    @finalized_cell.finalized?.must_equal true
  end

  it "should have a non-zero value when finalized" do
    @non_finalized_cell.subtract_from_possible_values(["1","2","3","4","5","6","7","8"])
    @non_finalized_cell.finalized?.must_equal true
    @non_finalized_cell.possible_values.count.must_equal 1
    @non_finalized_cell.possible_values.must_equal ["9"]
  end

  it "should not be finalized if it has more than one possible value" do
    @non_finalized_cell.possible_values.count.must_equal 9
    @non_finalized_cell.possible_values.must_equal ["1","2","3","4","5","6","7","8","9"]
    @non_finalized_cell.finalized?.must_equal false
  end

  describe "to_s method" do
    it "should return a string containing the cell's last possible value finalized" do
      @finalized_cell.possible_values.count.must_equal 1
      @finalized_cell.finalized?.must_equal true
      @finalized_cell.to_s.must_equal "2"
    end

    it "should return '0' when there are multiple possible_values" do
      @non_finalized_cell.to_s.must_equal "0"
    end
  end

  describe "equality" do
    it "should know when two cells are equal" do
      @non_finalized_cell.must_equal Cell.new("0")
      @finalized_cell.must_equal Cell.new("2")
    end

    it "should know when two cells are not equal" do
      @non_finalized_cell.wont_equal Cell.new("2")
      @finalized_cell.wont_equal Cell.new("0")
    end
  end



end
