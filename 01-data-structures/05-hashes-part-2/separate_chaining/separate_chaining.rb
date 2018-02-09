require_relative 'linked_list'
class Node
  attr_accessor :next
  attr_accessor :key
  attr_accessor :value

  def initialize(key, value)
    self.key = key
    self.value = value
  end
end


class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
  end

  def []=(key, value)
    item = @items[index(key,size)]
    if item == nil
      @items[index(key,size)] = Node.new(key,value)
      resize if @max_load_factor < load_factor
    elsif item.key == key
      item.value = value
    elsif item.key != key
      until item.next == nil
        item = item.next
      end
      @items[index(key,size)].next ||= Node.new(key,value)
      resize if @max_load_factor < load_factor
    end
  end

  def [](key)
    item = @items[index(key, size)]
    if item.key == key
      item.value
    elsif item.key != key
      until item.key == key
        item = item.next
        if !!item
          "there is no key:#{key}"
          break
        end
      end
      item.value
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    count = 0.0
    @items.each{ |ele|
      next unless ele
        count += 1
        until ele.next == nil
          ele = ele.next
          count += 1
        end
    }
  count/size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  # Resize the hash
  def resize
    temp = @items
    @items = Array.new(temp.size*2)
    temp.each do |ele|
      next unless ele #skip nil unless ele has value
      @items[index(ele.key,size)] = ele
      until ele.next == nil
        ele = ele.next
        @items[index(ele.key,size)] = ele
      end
    end
  end
end
