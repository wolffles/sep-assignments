range = (1..100).to_a
x_plane = (1..100).to_a
y_plane = (1..100).to_a
sample_cities = ('a'..'z').to_a
arbitrary_map = {}
small_map = {}
large_map = {}

arbitrary_map['a'] = Hash[
  'b',10,
  'c',15,
  'd',20,
]
arbitrary_map['b'] = Hash[
  'a',10,
  'c',35,
  'd',25,
]
arbitrary_map['c'] = Hash[
  'a',15,
  'b',35,
  'd',30,
]
arbitrary_map['d'] = Hash[
  'a',20,
  'b',25,
  'c',30,
]

#hash_format['a'] = {cord = [x,y], "a" = nil, "b" = nil ... "z" = nil}

def update_closest(array, city, new_dist)
  return array << [city,new_dist] if array.size < 3
  if new_dist < array[-1][1]
    array.pop
    i = 0
    while i < array.size
      if new_dist < array[i][1]
        array.insert(i,[city,new_dist])
        break
      end
      i += 1
    end
  end
end

def distance(map,a,b)
  return map[a][b] if map[a][b] != nil
  a_coords = map[a][:coords]
  b_coords = map[b][:coords]
  a_closest = map[a][:closest]
  b_closest = map[b][:closest]
  ax,ay,bx,by = a_coords[0],a_coords[1], b_coords[0], b_coords[1]
  if ax == bx || ay == by
    dist = [(ax - bx).abs, (ay - by).abs].max
    map[a][b],map[b][a] = dist, dist
    update_closest(a_closest, b, dist)
    update_closest(b_closest, a, dist)
    return dist
  else
    dist =  Math.sqrt(((ax - bx).abs**2) + ((ay - by).abs**2))
    map[a][b],map[b][a] = dist, dist
    update_closest(a_closest, b, dist)
    update_closest(b_closest, a, dist)
    return dist
  end
end

def create_map(city_hash, n)
  range = (1..100).to_a
  sample_cities = ('a'..'z').to_a
  cities = sample_cities.slice(0,n)
  cities.each{|ele| city_hash[ele] = Hash[
    :coords, [range.sample,range.sample],
    :closest, []
    ]
  }
end
  # create hash of x cities, each with its own [x,y] cord.
  # each city has its own distance map
  # (possibly find distance before tps call)
  # each city has a closest cities value.
  # distance for corresponding cities get added at the same time to save time.
