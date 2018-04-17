require_relative 'map-data'
# small_map ={}
# create_map(small_map, 10)

def brute_tsp(map)
  cities = map.keys # array of cities
  # combination = cities.combination(2).to_a
  # combination.each{|link| distance(map,link[0],link[1])}
  possibilities = cities.permutation(cities.size).to_a
  outcomes = []
  shortest = nil
  possibilities.each{|pop|
    total_dist,i = 0,0
    until i == pop.size - 1
      total_dist += distance(map,pop[i],pop[i+1])
      i+=1
    end
    shortest = total_dist.round(2) if shortest.nil? || total_dist.round(2) < shortest
    outcomes << total_dist.round(2)
  }
  best = possibilities[outcomes.find_index(shortest)]

  [best, shortest]

end

# brute_tsp(small_map)
