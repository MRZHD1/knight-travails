class Tree
  def initialize(start, final)
    @start = Node.new(start)
    @final = final
    @arr = []
  end

  def create_path(node=@start, arr=[])
    if node.position == @final
      return [node.position]
    end
    val = nil
    i = 0
    while @arr == [] do
      node.children = []
      node.make_children(0,i)
      find_path(node, arr)
      i += 1
    end
    return @arr
  end

  def find_path(node, arr)
    if arr.include?(@final)
      @arr = arr
      return
    end
    unless node.children == []
      for pos in node.children
        find_path(pos, arr + [node.position])
      end
    else
      return arr + [node.position]
    end
    return nil
  end
end

class Node
  attr_accessor :position
  attr_accessor :children
  def initialize(position)
    @position = position
    @children = []
  end

  def make_children(level, max)
    if @position[0] + 1 < 8
      if @position[1] + 2 < 8 
        @children += [Node.new([@position[0] + 1, @position[1] + 2])]
      end
      if @position[1] - 2 >= 0
        @children += [Node.new([@position[0] + 1, @position[1] - 2])]
      end
    end
    if @position[0] + 2 < 8
      if @position[1] + 1 < 8 
        @children += [Node.new([@position[0] + 2, @position[1] + 1])]
      end
      if @position[1] - 1 >= 0
        @children += [Node.new([@position[0] + 2, @position[1] - 1])]
      end
    end
    if @position[0] - 1 >= 0
      if @position[1] + 2 < 8 
        @children += [Node.new([@position[0] - 1, @position[1] + 2])]
      end
      if @position[1] - 2 >= 0
        @children += [Node.new([@position[0] - 1, @position[1] - 2])]
      end
    end
    if @position[0] - 2 >= 0
      if @position[1] + 2 < 8 
        @children += [Node.new([@position[0] - 2, @position[1] + 1])]
      end
      if @position[1] - 2 >= 0
        @children += [Node.new([@position[0] - 2, @position[1] - 1])]
      end
    end
    if level < max
      for child in self.children
        child.make_children(level + 1, max)
      end
    end
  end
end



def knight_moves(start, final)
  tree = Tree.new(start, final)
  path = tree.create_path
  s = "You made it in #{path.length-1} moves! Here's your path:"
  for move in path
    s += "\n  #{move}"
  end
  puts s
end

knight_moves([3,3], [4,3])