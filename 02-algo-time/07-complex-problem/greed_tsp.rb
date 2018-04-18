require_relative 'map-data'
# small_map ={}
# create_map(small_map, 5)

def greed_tsp(map, start = nil)
  cities = map.keys
   #start format: [ [a, tot_dist, [path] ] ]
  start ||= cities.map{|city| [city, 0, []]} # start array maintains best paths for each starting point
  ending = start # if you require a looped trip, ending will keep track of it, haven't coded a loop
  start.map{|st_end|
    best_path = [[st_end[0],0]] #format: [[city, distance ],[city, distance]]

      #until loop: populate aka(generate groups of near by points) from a start aka`st_end[0]` value, until you find the best grouping, add those values to best_path. then assign best path values to `start` array.
    until best_path.size == cities.size
      perm = populate(map,best_path,3,4) #perm stands for what populate returns
      shortest_index = []
      perm.each_with_index{|group,i|
        dist = 0
        group.each_with_index{|point,j| dist += point if j % 2 == 1}
        if shortest_index.empty? || dist <= shortest_index[1]
          shortest_index = [i,dist]
        end
      }
      best_path << [perm[shortest_index[0]][0], perm[shortest_index[0]][1]]
    end
      st_end[2] = convert(best_path)
      st_end[1] = calculate_dist(best_path)
  } #ending `start.map{}`
  best_path = start.min_by{|x| x[1]}
  [best_path[2], best_path[1]]
end

def populate(map, best_path, pop_size, n_pop)
  current, i, list = best_path[-1][0], 0, []
  possible_cities = convert(map[current][:closest]) - convert(best_path)
  population = map[current][:closest].first(pop_size)
  # if condition: adjusts pop_size if possible cites are less than pop_size
  if possible_cities.size < pop_size
    pop_size = possible_cities.size
    n_pop = pop_size
  end
  until (convert(population) - convert(best_path)).size  == pop_size
    population = map[current][:closest].first(pop_size+i)
    i += 1
  end
  population = population.select{|ele| !convert(best_path).include?(ele[0])}
  #condition: ends the recursion
  if (n_pop == 1)
		list = [];
		i = 0
		while i < population.size
			list.push(population[i]);
			i += 1
		end
		return list;
	end
  #while loop: each array in population is assigned to head, then calls recurses until n_pop = 1 where it breaks. the lower stacks bubble up; assigning return value `list` to variable `tail`. the final list returned is a permutation of `n_pop` values of pop_size points.
       #ex: [[x,x,x],[x,x,x],[x,x,x],[x,x,x]] pop_size = 4 & n_pop = 3
  j = 0
  while j < population.size
    head = population[j]
    temp_path = (best_path + [head])
    tail = populate(map, temp_path, pop_size, n_pop-1)
    k = 0
    while k < tail.size
      list << (head + tail[k])
      k += 1
    end
    j += 1
  end
  list
end
def convert(array) #converts population format to list of cities format.
  array.map{|ele| ele[0]}
end
def calculate_dist(array)
  total = 0
  array.each{|ele| total += ele[1]}
  total.round(2)
end

# greed_tsp(small_map)
