require_relative 'map-data'
require_relative 'brute_tsp'
require 'Benchmark'
arbitrary_map = {}

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

test_map = {}
create_map(test_map, 7)
shortest_path = brute_tsp(test_map)
# if tsp_greed.rb == shortest_path
  Benchmark.bm(7) do |x|
     x.report("brute_tsp"){brute_tsp(test_map)}
    # x.report("pruning"){optimize_written_ruby(ary1,ary2,ary3)}
    # x.report("complexity"){complexity_written_ruby(ary1,ary2,ary3)}
    # x.report("space"){space_written_ruby(array)}
  end
  # else
  # puts "some don't function properly."
# end
