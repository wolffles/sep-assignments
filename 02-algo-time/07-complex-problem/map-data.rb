range = (1..100).to_a
x_plane = (1..100).to_a
y_plane = (1..100).to_a
sample_cities = ('a'..'z').to_a
arbitrary_map = {}
small_map = {}
large_map = {}

#hash_format['a'] = {cord = [x,y], "a" = nil, "b" = nil ... "z" = nil}

def distance(a,b)
  ax, ay, bx, by = a[0], a[1], b[0], b[1]
  if ax == bx || ay == by
    return [(ax - bx).abs, (ay - by).abs].max
  else
  return Math.sqrt(((ax - bx).abs**2) + ((ay - by).abs**2)).round(2)
  end
end


arbitrary_map['a'] = Hash[
  'b',5,
  'c',6,
  'd',7,
]
arbitrary_map['b'] = Hash[
  'a',5,
  'c',1,
  'd',2,
]
arbitrary_map['c'] = Hash[
  'a',6,
  'b',1,
  'd',4,
]
arbitrary_map['d'] = Hash[
  'a',7,
  'b',2,
  'c',4,
]


def create_map(n, city_hash)
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
