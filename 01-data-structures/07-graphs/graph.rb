class Node
  attr_accessor :name
  attr_accessor :film_actor_hash

  def initialize(name)
    self.name = name
    self.film_actor_hash = {}
  end
end

require_relative 'nodes'
class Graph
  attr_accessor :actors
  attr_accessor :films
  def initialize
    @actors = []
    @films = []
  end


  #inserts a node into film or actors array
  def insert(node, type)
    if type == "actor"
      array = @actors
    elsif type == "film"
      array = @films
    end
    if array.empty?
      array.push(node)
    else
      index = [*array.each_with_index].bsearch{|x,_| node.name <= x.name}
      index.nil? ? array.push(node) : array.insert(index.last, node)
    end
    #do a sorted array for fast finds and quick manipulation
    # use locate which has a bsearch search for faster insert
  end

  def find(node)
    locate(node.name, 'actor')
  end
  #starts with a node and returns at most 6 film titles that connect it to kevin bacon
  # as long as the algorithm gets to one of kevin bacons films
  #2 films have a relation if an actor has both in its film_actor hash
  def six_degrees_KB(actor_node)
    #returns "not an actor from our database". if actor doesnt exist
    if locate("kevin_bacon", 'actor').nil?
      return "kevin bacon entree has not been added"
    end
    if locate(actor_node.name, "actor").nil?
      return "not an actor from our database."
    elsif actor_node.name == "kevin_bacon"
      return "redundant question actor is kevin_bacon"
    end
    forward = actor_node.film_actor_hash
    degrees = 1
    kevin_movies = locate("kevin_bacon", "actor").film_actor_hash
    #check to see if kevin bacon and starting array have in common
    until (forward.keys & kevin_movies.keys).size > 0 || degrees > 6
      # turned forward from list of movies to list of actors
      forward = forward.values.map{|x| x.film_actor_hash.values}.flatten.uniq
      #flatten uniq to retain single depth and only hold unique items
      #calls code again to have forward as a list of movies
      forward = forward.map{|x| x.film_actor_hash.to_a}.flatten(1).to_h
      degrees += 1
    end
      if degrees > 6
        return "kevin bacon not in 6 degrees of #{actor_node.name}"
      end
      #combination of the two arrays to return the starting point for "echo back"
      backward = (forward.to_a & kevin_movies.to_a).to_h
      #if match happens transverse backward to find the route(s) that matches
      #if backward.size > 1 means youve got multiple paths and you must choose one path. it doesn't matter which becuase its all the same degree.
    if backward.size > 1
      backward = backward[0]
    end
    origin = actor_node.film_actor_hash
    # until we reach origin's films
    until (backward.keys & origin.keys).size > 0
      backward = backward.values.map{|x| x.film_actor_hash.values}.flatten.uniq
      backward = backward.map{|x| x.film_actor_hash.to_a}.flatten(1).to_h
     end
     #comparing the foward and back similarities will return a single path
     paths = forward.keys & backward.keys
    return paths
  end

  private

  def locate(value, type)
    if type == "actor"
      array = @actors
    elsif type == "film"
      array = @films
    end
    array.bsearch{|ele| value <=> ele.name}
  end
end


# ["a",'b','c','d','e','f','g','h','i','j','kevin_bacon','l','m','n','o','p']
#
# graph = Graph.new()
#
# a= Node.new("a")
# b= Node.new("b")
# c= Node.new("c")
# d= Node.new("d")
# e= Node.new("e")
# f= Node.new("f")
# g= Node.new("g")
# h= Node.new("h")
# i= Node.new("i")
# j= Node.new("j")
# kevin_bacon= Node.new("kevin_bacon")
# l= Node.new("l")
# m= Node.new("m")
# n= Node.new("n")
# o= Node.new("o")
# p= Node.new("p")
# q= Node.new("q")
# r= Node.new("r")
# s= Node.new("s")
#
# one = Node.new("one")
# two = Node.new("two")
# three = Node.new("three")
# four = Node.new("four")
# five = Node.new("five")
# six = Node.new("six")
# seven = Node.new("seven")
# eight = Node.new("eight")
# nine = Node.new("nine")
# ten = Node.new("ten")
# eleven = Node.new("eleven")
# twelve = Node.new("twelve")
# thirteen = Node.new("thirteen")
# fourteen = Node.new("fourteen")
# fifteen = Node.new("fifteen")
# sixteen = Node.new("sixteen")
# seventeen = Node.new("seventeen")
# eighteen = Node.new("eighteen")
# nineteen = Node.new("nineteen")
#
# a.film_actor_hash['sixteen'] = sixteen
# a.film_actor_hash['one'] = one
# b.film_actor_hash['one'] = one
# b.film_actor_hash['two'] = two
# c.film_actor_hash['two'] = two
# c.film_actor_hash['three'] = three
# d.film_actor_hash['three'] = three
# d.film_actor_hash['four'] = four
# e.film_actor_hash['four'] = four
# e.film_actor_hash['five'] = five
# f.film_actor_hash['five'] = five
# f.film_actor_hash['six'] = six
# g.film_actor_hash['six'] = six
# g.film_actor_hash['seven'] = seven
# h.film_actor_hash['seven'] = seven
# h.film_actor_hash['eight'] = eight
# i.film_actor_hash['eight'] = eight
# i.film_actor_hash['nine'] = nine
# j.film_actor_hash['nine'] = nine
# j.film_actor_hash['ten'] = ten
# l.film_actor_hash['ten'] = ten
# l.film_actor_hash['eleven'] = eleven
# m.film_actor_hash['eleven'] = eleven
# m.film_actor_hash['twelve'] = twelve
# n.film_actor_hash['twelve'] = twelve
# n.film_actor_hash['thirteen'] = thirteen
# o.film_actor_hash['thirteen'] = thirteen
# o.film_actor_hash['fourteen'] = fourteen
# p.film_actor_hash['fourteen'] = fourteen
# p.film_actor_hash['fifteen'] = fifteen
# kevin_bacon.film_actor_hash['fifteen'] = fifteen
# kevin_bacon.film_actor_hash['sixteen'] = sixteen
#
# one.film_actor_hash['kevin_bacon'] = kevin_bacon
# one.film_actor_hash['a'] = a
# two.film_actor_hash['a'] = a
# two.film_actor_hash['b'] = b
# three.film_actor_hash['b'] = b
# three.film_actor_hash['c'] = c
# four.film_actor_hash['c'] = c
# four.film_actor_hash['d'] = d
# five.film_actor_hash['d'] = d
# five.film_actor_hash['e'] = e
# six.film_actor_hash['e'] = e
# six.film_actor_hash['f'] = f
# seven.film_actor_hash['f'] = f
# seven.film_actor_hash['g'] = g
# eight.film_actor_hash['g'] = g
# eight.film_actor_hash['h'] = h
# nine.film_actor_hash['h'] = h
# nine.film_actor_hash['i'] = i
# ten.film_actor_hash['i'] = i
# ten.film_actor_hash['j'] = j
# eleven.film_actor_hash['j'] = j
# eleven.film_actor_hash['l'] = l
# twelve.film_actor_hash['l'] = l
# twelve.film_actor_hash['m'] = m
# thirteen.film_actor_hash['m'] = m
# thirteen.film_actor_hash['n'] = n
# fourteen.film_actor_hash['n'] = n
# fourteen.film_actor_hash['o'] = o
# fifteen.film_actor_hash['o'] = o
# fifteen.film_actor_hash['p'] = p
# sixteen.film_actor_hash['p'] = p
# sixteen.film_actor_hash['kevin_bacon'] = kevin_bacon
