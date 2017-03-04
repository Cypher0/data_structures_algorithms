class Square
  attr_accessor :row, :col, :parent, :children, :coords

  def initialize(coords, parent = nil, children = [])
    @coords = coords
    @parent = parent
    @children = children
  end
end

def valid_target?(target)
  (0..7).cover?(target[0]) && (0..7).cover?(target[1])
end

def possible_moves(location, moves = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]])
  moves.each do |move|
    target_coords = move[0] + location.coords[0], move[1] + location.coords[1]
    next unless valid_target?(target_coords)
    location.children << Square.new(target_coords, location)
  end
end

def show_path(location, path = [])
  until location.nil?
    path << location.coords
    location = location.parent
  end
  puts "You made it in #{path.size - 1} moves! Here's your path:"
  path.reverse.each do |move|
    puts move.inspect
  end
end

def input_error
  puts 'Invalid input, please make sure coordinates are between 0 and 7.'
  return
end

def knight_moves(start, target)
  input_error unless valid_target?(start) && valid_target?(target)
  queue = [Square.new(start)]
  visited = [queue.first.coords]
  until queue.empty?
    current = queue.shift
    if current.coords == target
      show_path(current)
    else
      visited << current.coords
      possible_moves(current)
      current.children.each do |child|
        queue << child unless visited.include?(child.coords)
        visited << child.coords unless visited.include?(child.coords)
      end
    end
  end
end

knight_moves([0,0],[2,5])
knight_moves([0,0],[7,7])
knight_moves([0,0],[0,1])