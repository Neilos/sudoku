
class Cell
  attr_accessor :possibilities
  attr_reader :position

  def initialize(value, position)
    raise ArgumentError unless value.is_a?(String)
    @possibilities = (value == "0") ? ["1","2","3","4","5","6","7","8","9"] : [value.to_s]
    @position = position
  end

  def subtract_from_possibilities(impossibilities)
    self.possibilities = possibilities - impossibilities
  end

  def finalized?
    possibilities.count == 1
  end

  def to_s
    finalized? ? possibilities.first : "0"
  end
  
end
