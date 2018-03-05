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
    end
      forward = (forward.to_a & kevin_movies.to_a).to_h
    #if match happens transverse backward to find the route(s) that matches
    if forward.size >0
      #combination of the two arrays to return the ending nodes
      backward = (forward.to_a & kevin_movies.to_a).to_h
      origin = actor_node.film_actor_hash
      #until we reach the beginning
      # until (backward.keys & origin.keys).size > 0 || degrees > 6
      #   backward = backward.values.map{|x| x.film_actor_hash.values}.flatten.uniq
      #   backward = backward.map{|x| x.film_actor_hash.to_a}.flatten(1).to_h
      # end
      #comparing the two and returning similarities will give you all the paths that match
      paths = forward.keys #& kevin_movies.keys
      # & backward.keys
    end
    #haven't implimented the single path code but for our tests it only returns 1 path, in a real database it would return multiple paths to the same degree
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
