require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    self.matrix = Array.new(10,Array.new(10))
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
     self.matrix[y][x] = pixel if inbounds(x,y)
  end

  def at(x, y)
    self.matrix[y][x]
  end

  private

  def inbounds(x, y)
    !!matrix.fetch(y,false) && !matrix.fetch(y).fetch(x,true) ? true : false
  end

end
