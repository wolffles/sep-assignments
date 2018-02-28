require_relative 'node'
class MinHeapTree
  attr_accessor :tree

  def initialize
    @tree = Array.new(3)
    @leaf_row = 1 #help with resizing array
  end

  def insert(node)
    @tree.push(node)
    min_bubble(-1)

  end

  def find(data)
    return nil if data == nil
    index = @tree.find_index{|x|
      break if x == nil # because expanded our array in advance
      x.title == data}
    return nil if index == nil
    @tree[index]
    # since a heap is unsorted there is no way of optomizing its search and the best average you can hope for is still O(n)
  end

  def delete( data)
    return nil if data == nil
    target = @tree.find_index{|x|
      break if x == nil
      x.title == data
    }
    return nil if target == nil
    @tree[target] = @tree[-1]
    @tree.pop
    heapify(target)

  end

  def printf
    @tree.each{|x|
       break if x == nil
      puts "#{x.title}: #{x.rating}"
    }
  end

  private

  def resize
    temp = @tree
    @leaf_row += 1
    @tree = Array.new(2**@leaf_row + temp.length)
    temp.each_with_index do |t,i|
       if t
          @tree[i] = t
       end
    end
  end

  def left(index)
    index * 2 + 1
  end

  def right(index)
    index * 2 + 2
  end

  def parent(index)
    (index -1)/2
  end
  #recursive method to bubble sort
  #from the bottom up
  #check new value with parent value
  def min_bubble(index)
    return nil if index == 0
    parent = (index-1)/2
    if @tree[index].rating < @tree[parent].rating
      temp = @tree[index]
      @tree[index] = @tree[parent]
      @tree[parent] = temp
      min_bubble(parent)
    end
  end

  #from the top down
  #check to see which children are smaller and swap
  #recurse
  def heapify(index)
    left = @tree[left(index)]
    right = @tree[right(index)]
    current = @tree[index]
    if !left && !right # if no children exist nothing to compare with
      nil
    elsif left && !right
      if left.rating < current.rating
        temp = @tree[index]
        @tree[index] = @tree[left]
        @tree[left] = temp
        #no need to heapify at a leaf
      end
    elsif left.rating < current.rating || right.rating < current.rating
      if @tree[left].rating <= @tree[right].rating
        temp = @tree[index] #current index and left swap if it's the smaller of two children
        @tree[index] = @tree[left]
        @tree[left] = temp
        heapify(left(index))
      elsif @tree[right].rating < @tree[left].rating
        temp = @tree[index] #current index and left swap if it's the smaller of two children
        @tree[index] = @tree[right]
        @tree[right] = temp
        heapify(right(index))
      end
    end
  end
end
