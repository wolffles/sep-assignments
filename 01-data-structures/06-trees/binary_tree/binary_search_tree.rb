require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
  end

  def insert(root, node)
    if node.rating <= root.rating
      if root.left.nil?
        root.left = node
        node.parent = root
      else
        insert(root.left, node)
      end
    elsif node.rating > root.rating
      if root.right.nil?
        root.right = node
        node.parent = root
      else
        insert(root.right, node)
      end
    end
  end


  # Recursive Depth First Search returns node
  def find(root, data)
   node = root
   if !root.nil? && root.title != data # gracefully handle nil, skips if match
     if !root.left.nil? #if left child exists
       node = find(root.left, data) # recursive left as root
     elsif !root.right.nil?
       node = find(root.right, data)
     else
      node = nil # if end of the tree
     end
   end
   return node
 end


  def delete(root, data)
    return nil if data == nil
    target = find(root, data)
    return nil if target == nil
    parent_root = target.parent
    target_left = target.left
    target_right = target.right

    if parent_root
      parent_root.left = target_left
      parent_root.right = target_right
    end
  end

  def printf(children=nil)
    children = [@root] if !children
    nextRow = []
    children.each do |child|
      puts "#{child.title}: #{child.rating}"
      nextRow.push(child.left) if !!child.left
      nextRow.push(child.right) if !!child.right
    end
    if nextRow.size == 0
      return nil
    else
      printf(nextRow)
    end
  end
end
