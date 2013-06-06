class BoardStructure

def initialized(*args)
  @width = args[:width] || 9
  @height = args[:height] || 9
  @box_width = args[:box_width] || 3
  @box_height = args[:box_height] || 3
end

end
