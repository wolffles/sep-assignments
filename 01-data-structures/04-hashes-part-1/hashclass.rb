
class HashClass

  def initialize(size=5)
    @items = Array.new(size=5)
  end

  def []=(key, value)
    if @items[index(key,size)] == nil
      @items[index(key, size)] = HashItem.new(key,value)
    else
      resize
      @items[index(key,size)] = HashItem.new(key,value)
    end
  end


  def [](key)
    @items[index(key,size)].value
  end

  def resize
    #ideally you'd want to find the next greater number in powers of two and find the closest greater than number.
    #but for this example im using a static values from the checkpoint
    next_primes = [5, 8, 16, 32, 64, 128, 256]
    next_index = next_primes.find_index(size)+1
    temp = Array.new(next_primes[next_index])
    @items.each{|ele|  temp[index(ele.key,size)] = HashItem.new(ele.key,ele.value) if ele != nil }
    @items = temp
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    x = 0
    for i in 0..key.length-1 do # same as (0..key.length-1).each {|i| code}
      ascii_code = key[i].ord
      x += 128 * x + ascii_code
    end
    return x % size
  end

  # Simple method to return the number of items in the hash
  def size
    #ideally youd want to find the next greater number in powers of two and find the closest greater than number.
    #but for this example im using a static value up to 100 places
    @items.size
  end
end
