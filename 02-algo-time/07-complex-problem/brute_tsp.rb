require_relative 'map-data'
require 'byebug'
def brute_tsp(map)
  cities = map.keys # array of cities
  possibilities = cities.permutation(cities.size).to_a
  outcomes = []
  possibilities.each{|pop|
    total_dist,i = 0,0
    until i == pop.size - 1
      total_dist += distance(map,pop[i],pop[i+1])
      i+=1
    end
    outcomes << total_dist.round(2)
  }
  shortest = outcomes.min
  best = possibilities[outcomes.find_index(shortest)]
  # puts outcomes.count(shortest)
  # if outcomes.count(shortest) < 2
  #   byebug
  # end
  best
  # puts best
end
