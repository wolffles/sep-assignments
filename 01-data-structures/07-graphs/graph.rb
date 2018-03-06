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

  def find_actor(node)
    locate(node.name, 'actor')
  end

  def six_degrees_KB(actor_node)
    if locate("kevin_bacon", 'actor').nil?
      return "kevin bacon entree has not been added"
    end
    if locate(actor_node.name, "actor").nil?
      return "not an actor from our database."
    elsif actor_node.name == "kevin_bacon"
      return "redundant question actor is kevin_bacon"
    end
    #this algorithm works like a sonar
    forward = actor_node.film_actor_hash
    degrees = 1
    kevin_movies = locate("kevin_bacon", "actor").film_actor_hash
    until (forward.keys & kevin_movies.keys).size > 0 || degrees > 6
      # turns forward from hash of movies to list of actors
      forward = forward.values.map{|x| x.film_actor_hash.values}.flatten.uniq
      #flatten to retain single depth and only hold uniq items
      #calls code again to have forward as a list of movies
      forward = forward.map{|x| x.film_actor_hash.to_a}.flatten(1).to_h
      degrees += 1
    end
    if degrees > 6
      return "kevin bacon not in 6 degrees of #{actor_node.name}"
    end
    #combine the two arrays to return the starting point for "echo back"
    backward = (forward.to_a & kevin_movies.to_a)
    #if backward.size > 1 means youve got multiple paths and you must choose one path. it doesn't matter which becuase it's all the same degree.
    if backward.size > 1
      #remember to keep in hash format using []
      backward = [backward[0]]
    end
    backward = backward.to_h
    origin = actor_node.film_actor_hash
    # until we reach origin's films
    until (backward.keys & origin.keys).size > 0
      backward = backward.values.map{|x| x.film_actor_hash.values}.flatten.uniq
      backward = backward.map{|x| x.film_actor_hash.to_a}.flatten(1)
      #to avoid redundancy and "ghost paths" (nodes a that appear in both directions but aren't part of the path)
      #if its not part of forward path if not then no need to check it.
      backward = backward.select{|x| !forward[x[0]].nil? }.to_h
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
