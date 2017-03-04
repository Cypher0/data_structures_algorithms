require_relative 'lib/square'

# check if given coordinates are within the board
def valid_target?(target)
  (0..7).cover?(target[0]) && (0..7).cover?(target[1])
end

# check all possible moves from a given position and add them as the current
#   locations children if their coordinates are within the board
def possible_moves(location, moves = [[1,2],[1,-2],[-1,2],[-1,-2],[2,1],[-2,1],[2,-1],[-2,-1]])
  moves.each do |move|
    target_coords = move[0] + location.coords[0], move[1] + location.coords[1]
    next unless valid_target?(target_coords)
    location.children << Square.new(target_coords, location)
  end
end

# backtrack to the beginning of the path using the parent-children relationship,
#   map the path's moves to an array, reverse it and display moves.
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

# return an error if the given start/end coordinates are not within the board
def input_error
  puts 'Invalid input, please make sure coordinates are between 0 and 7.'
  return
end

# take a knight's starting and target positions as arguments, traverse all possible
#   paths using dfs, return the shortest path's moves
def knight_moves(start, target)
  input_error unless valid_target?(start) && valid_target?(target)
  queue = [Square.new(start)]
  visited = [queue.first.coords]
  until queue.empty?
    current = queue.shift
    if current.coords == target # if the target square is reached, it has to be
      show_path(current) # the shortest path, call the method to display it
    else
      visited << current.coords # mark the current location as visited,
      possible_moves(current) # execute each possible move,
      current.children.each do |child| # add all legitimate targets to the queue
        queue << child unless visited.include?(child.coords) # unless already enqueued
        visited << child.coords unless visited.include?(child.coords) # or visited
      end
    end
  end
end

knight_moves([0,0],[2,5])
knight_moves([0,0],[7,7])
knight_moves([0,0],[0,1])