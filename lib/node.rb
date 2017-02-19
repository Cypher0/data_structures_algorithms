class Node
  attr_accessor :value, :parent, :lchild, :rchild

  def initialize(value, parent = nil, lchild = nil, rchild = nil)
    @value = value
    @parent = parent
    @lchild = lchild
    @rchild = rchild
  end
end
