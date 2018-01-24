class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
  end

  def enqueue(element)
    @queue.push(element)
    self.head = @queue[0]
    self.tail = @queue[-1]
  end

  def dequeue
    @queue.shift
    self.head = @queue[0]
    self.tail = @queue[-1]
  end

  def empty?
    @queue.empty?
  end
end
