require 'byebug'


class PolyTreeNode

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end


  def parent
    @parent 
  end
  
  def children
    @children
  end

  def value
    @value
  end

  def parent=(parent_node)
    if @parent.nil?
      @parent = parent_node
      parent_node.add_child(self)
    else
      @parent.children.delete(self) if parent
      @parent = parent_node
      parent_node.children << self unless parent_node.nil? || 
      parent_node.children.include?(self)
    end
  end

 
  def remove_child(child_node)
    child_node.parent = nil
    @children.delete(child_node)
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def inspect
    "<Value: #{value} Parent: #{parent} Children: #{children}>" 
  end

  def dfs(target_value)
    return self if self.value == target_value
    self.children.each do |child|
      last_value = child.dfs(target_value)
      return last_value unless last_value.nil?
    end
    nil
  end

  def bfs(target_value)
    myQueue = []
    myQueue.push(self)
    until myQueue.empty?
      cur_node = myQueue.shift
      if cur_node.value == target_value
        return cur_node
      else
        myQueue += cur_node.children
      end
    end
  end
end