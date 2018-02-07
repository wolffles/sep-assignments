require 'prime'

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    if @items[index(key,size)] == nil #if bucket is empty
      @items[index(key, size)] = HashItem.new(key,value)
    elsif @items[index(key,size)].key != key # if this bucket exist already.
      resize
      self[key] = value
      # after you've resized it you'll need to call self[key] because of scoping issues. when resize reassigns the variable it makes the current reference obsolete. reassigning or assign a variable with the same name is not the same as referencing an object and changing its value.
    elsif @items[index(key,size)].key === key && @items[index(key,size)].value != value
      resize
      @items[index(key, @items.length)].value = value
    end
  end


  def [](key)
    @items[index(key,size)].value
  end

  # def resize
  #   i = size
  #   next_prime = false
  #   until(next_prime)
  #     i += 1
  #     next_prime = i.prime?
  #   end
  #   temp = Array.new(i)
  #   @items.each{|ele|  temp[index(ele.key,size)] = HashItem.new(ele.key,ele.value) if ele != nil }
  #   @items = temp
  # end

  def resize
    temp = @items
    @items = Array.new(temp.size*2)
    temp.each do |t|
       if t
          @items[index(t.key, size)] = t
       end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  # def index(key, size)
  #   x = 0
  #   for i in 0..key.length-1 do # same as (0..key.length-1).each {|i| code}
  #     ascii_code = key[i].ord
  #     x += 128 * x + ascii_code
  #   end
  #   return x % size
  # end
  def index(key,size)
    x = 0
    for i in 0..key.length-1 do
      ascii_code = key[i].ord
      x += ascii_code
    end
    return x % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end
end
