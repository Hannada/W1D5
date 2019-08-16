class PolyTreeNode
  attr_reader :children, :value, :parent 
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end

  def parent=(node)
    if !self.parent.nil?
      self.parent.children.select! {|ele| ele != self}
    end

    if node.nil?
      @parent = nil
    elsif !node.children.include?(self)    
      @parent = node  
      @parent.children << self 
    end 
    @parent
  end

  def add_child(child_node)
    child_node.parent = self 

  end

  def remove_child(child_node)
    raise "Not a child" if !self.children.include?(child_node)
    child_node.parent = nil 
  end

  def dfs(target_value)
    return self if self.value == target_value
    if !self.children.empty?
      self.children.each do |child|
        result = child.dfs(target_value)
        return result if !result.nil? 
      end
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      check_node = queue.shift
      if check_node.value == target_value
        result = check_node
        return result if !result.nil? 
      else
        queue += check_node.children
      end
    end
    nil
  end


end