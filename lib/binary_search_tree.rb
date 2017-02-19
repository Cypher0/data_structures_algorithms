class BinarySearchTree
  require_relative 'node'
  attr_accessor :root

  def initialize(ary)
    build_tree(ary)
  end

  def add_node(val, root)
    if val <= root.value
      if root.lchild.nil?
        root.lchild = Node.new(val, root)
      else
        add_node(val, root.lchild)
      end
    else
      if root.rchild.nil?
        root.rchild = Node.new(val, root)
      else
        add_node(val, root.rchild)
      end
    end
  end

  def build_tree(ary)
    nodes = ary.shuffle!
    @root = Node.new(nodes[0])
    nodes.each_with_index do |val, ind|
      next if ind.zero?
      add_node(val, @root)
    end
  end

  def breadth_first_search(val)
    queue = [@root]
    count = 0
    until queue.empty?
      node = queue.first
      if node.value == val
        search_result(node)
        count += 1
      end
      queue << node.lchild unless node.lchild.nil?
      queue << node.rchild unless node.rchild.nil?
      queue.shift
    end
    puts "\nFound #{count} results."
  end

  def depth_first_search(val)
    stack = [@root]
    count = 0
    until stack.empty?
      node = stack.pop
      if node.value == val
        search_result(node)
        count += 1
      end
      stack << node.lchild unless node.lchild.nil?
      stack << node.rchild unless node.rchild.nil?
    end
    puts "\nFound #{count} result(s)."
  end

  def dfs_rec(val, active_node = @root)
    search_result(active_node) if active_node.value == val
    dfs_rec(val, active_node.lchild) unless active_node.lchild.nil?
    dfs_rec(val, active_node.rchild) unless active_node.rchild.nil?
  end

  def search_result(node)
    result = ''
    result << "Node found:\n\nValue: #{node.value}\nParent: "
    node.parent.nil? ? result << "None\nLeft Child: " : result << "#{node.parent.value}\nLeft Child: "
    node.lchild.nil? ? result << "None\nRight Child: " : result << "#{node.lchild.value}\nRight Child: "
    node.rchild.nil? ? result << "None\n" : result << "#{node.rchild.value}\n"
    puts "\n#{result}"
  end
end

tree = BinarySearchTree.new([25, 45, 1, 36, 23, 18, 13, 5, 15, 50, 3, 32, 15, 10, 43, 8, 26, 17, 25, 37, 48, 13, 7, 6, 43])
tree.breadth_first_search(13)
tree.depth_first_search(13)
tree.dfs_rec(13)
