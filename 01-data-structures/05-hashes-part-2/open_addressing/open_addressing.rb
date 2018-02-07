#my open_addressing hash function uses a linked list method, although not as effecient as a indexing function that just resists collisions, this function checks a key's intended index, using next_open_index to find an availiable spot, if not it resizes and trys again. and as for searching the indexin function will direct the key's intended index and if the key doesnt match use the node's next attribute to find where a next index would be. avoiding having to enumerate over every element. 
require_relative 'node'

class Node
  attr_accessor :next
  attr_accessor :key
  attr_accessor :value

  def initialize(key, value)
    self.key = key
    self.value = value
  end
end


class OpenAddressing

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    node = Node.new(key, value)
    idx = next_open_index(index(key,size))
    if idx == -1
      resize
      self[key] = value
    else
      @items[idx] = node
    end
  end

  def [](key)
    idx = index(key,size)
    if @items[idx].key == key
      @items[idx].value
    elsif @items[idx].key != key
      @items[@items[idx].next].value
    end


  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    x = 0
    for i in 0..key.length-1 do
      ascii_code = key[i].ord
      x += ascii_code
    end
    return x % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    if @items[index] != nil
      if @items.find_index(nil) == nil
        index = -1
      else
        @items[index].next = @items.find_index(nil)
        index = @items.find_index(nil)
      end
    end
    index
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  # Resize the hash
  def resize
    temp = @items
    @items = Array.new(temp.size*2)
    temp.each do |t|
      next unless t #skip nil unless t has value
      @items[index(t.key,size)] = t
    end
  end

end
