class Square
  attr_accessor :parent, :children, :coords

  def initialize(coords, parent = nil, children = [])
    @coords = coords
    @parent = parent
    @children = children
  end
end
