class Node
  attr_accessor :name
  attr_accessor :film_actor_hash

  def initialize(name)
    self.name = name
    self.film_actor_hash = {}
  end

  def inspect
    "#<#{self.class}:0x%x #{self.name}>" % object_id
  end

end

#add film : actors relation to film_actor hash
# variable_name.name = actor name
# variable_name.film_actor_hash[film] = [list of actors]
