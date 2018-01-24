class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
  end

  def push(item)
    @stack << item
    self.top = @stack.last
  end

  def pop
    item = @stack.pop
    self.top = @stack.last
    item

  end

  def empty?
    @stack.empty?
  end
end
