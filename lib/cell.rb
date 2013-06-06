
class Cell
include Comparable
attr_accessor :possible_values
attr_reader :index

def initialize(value)
  raise ArgumentError unless value.is_a?(String)
  @possible_values = (value == "0") ? ["1","2","3","4","5","6","7","8","9"] : [value.to_s]
end

def subtract_from_possible_values(impossible_values)
  self.possible_values = possible_values - impossible_values
end

def finalized?
  possible_values.count == 1
end

def to_s
  finalized? ? possible_values.first : "0"
end

def <=>(other_cell)
  self.possible_values <=> other_cell.possible_values
end

end
