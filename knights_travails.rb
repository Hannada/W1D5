require_relative "./skeleton/lib/00_tree_node.rb"

class KnightPathFinder
  attr_reader :position, :considered_positions, :root_node 

  def self.valid_moves(pos)
    #Check for 0 < n < 7
    #Check Knight L moveability

    pot_moves = [[2,1], [2,-1], [-2,1], [-2,-1], [1,2], [1,-2], [-1,2], [-1,-2]]
    valid_move = []

    pot_moves.each do |moves|
      current_move = [pos.first + moves.first, pos.last + moves.last]
      if current_move.all? {|ele| ele>=0 && ele<=7}
        valid_move << current_move
      end
    end
    valid_move
  end

  def initialize(pos)
    @position = pos
    @considered_positions = [] 
  end

  def new_move_positions(pos)
    valid =  KnightPathFinder.valid_moves(pos)
    remaining_pos = valid.reject {|move| @considered_positions.include?(move)}
    @considered_positions += remaining_pos
    remaining_pos
  end

  def build_move_tree
    @root_node = PolyTreeNode.new(self.position)
    queue = [@root_node]  #Create node queue

    until queue.empty?
      check_node = queue.shift 
      pos_arr = new_move_positions(check_node.value)
      pos_arr.each do |pos|
        p = PolyTreeNode.new(pos)  #Create new node
        p.parent = check_node   #Designate parent of new node
        # p.children << new_move_positions(pos)  #Add children to new node
        queue << p
      end
    end
  end

end