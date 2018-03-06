class Node
  attr_accessor :name
  attr_accessor :film_actor_hash

  def initialize(name)
    self.name = name
    self.film_actor_hash = {}
  end

  # stops inspect from recursivly looking at the inner hash.
  def inspect
    "#<#{self.class}:0x%x #{self.name}>" % object_id
  end

end
