require_relative 'map-data'
require_relative 'brute_tsp'
require_relative 'greed_tsp'
require 'Benchmark'
test_map = {}
small_map = {}
create_map(test_map, 8)
a = greed_tsp(test_map)
b = brute_tsp(test_map)
p "greed: #{a}"
p "brute: #{b}"
p a[0] == b[0]

create_map(small_map, 26) # does not go higher than 26 because the cities are only a-z

  Benchmark.bm(7) do |x|
    x.report("brute_tsp_test"){brute_tsp(test_map)}
    x.report("greed_tsp_test"){greed_tsp(test_map)}
    x.report("greed_tsp_small"){greed_tsp(small_map)}
    # x.report("brute_tsp_small"){brute_tsp(small_map)}
    #takes too long

  end
