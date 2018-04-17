require 'byebug'

#hash_format['a'] = {:coords = [x,y], :closest = [], "a" = nil, "b" = nil ... "z" = nil}

#binary_insert for updating_closest
 def binary_insert(array, val)
   return 0 if array.empty?
   low, high = 0, array.length - 1
   while low <= high
     mid = ((low + high) / 2.0).ceil
     if val < array[mid][1]
       high = mid - 1.0
     elsif val > array[mid][1]
       low = mid + 1.0
     else
       return mid
     end
   end
   return ((low + high) / 2.0).ceil
 end

#updates closest attribute for a city
def update_closest(array, city, new_dist)
  if !array.include?([city, new_dist])
    insert_point = binary_insert(array, new_dist)
    array.insert(insert_point,[city, new_dist])
  end
end

#determins distance
def distance(map,a,b)
  a_coords = map[a][:coords]
  b_coords = map[b][:coords]
  a_closest = map[a][:closest]
  b_closest = map[b][:closest]
  ax,ay,bx,by = a_coords[0],a_coords[1], b_coords[0], b_coords[1]

  if map[a][b] != nil
    dist = map[a][b]
    update_closest(a_closest, b, dist)
    return dist
  end
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
#create the map
def create_map(map, n)
  range = (1..100).to_a
  sample_cities = ('a'..'z').to_a
  cities = sample_cities.slice(0,n)
  cities.each{|ele| map[ele] = Hash[
    :coords, [range.sample,range.sample],
    :closest, []
    ]
  }
  #checking distance between all values to create a :closest attribute and distance values
  combination = cities.combination(2).to_a
  combination.each{|link| distance(map,link[0],link[1])}
end
