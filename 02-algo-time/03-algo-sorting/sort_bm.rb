require 'Benchmark'
require_relative 'bucket_sort'
require_relative 'bucket_sort2'
require_relative 'heap_sort'
require_relative 'quick_sort'
require_relative 'counting_sort'

ary = (1..100000).to_a.shuffle
sorted = (1..100000).to_a
puts "check to see if all return the same ary"
puts "quick: #{quick_sort(ary,0,ary.size-1) == sorted}"
puts "counting: #{counting_sort(ary) == sorted}"
puts "bucket: #{bucket_sort(ary) == sorted}"
puts "bucket2: #{bucket_sort2(ary) == sorted}"
puts "heap: #{heap_sort(ary) == sorted}"

ary = (1..100000).to_a.shuffle
Benchmark.bm(7) do |x|
  x.report("quick_sort:"){quick_sort(ary,0,ary.size-1)}
  x.report("counting_sort:"){counting_sort(ary)}
  x.report("bucket_sort_hash_sort:"){bucket_sort(ary)}
  x.report("bucket_sort_counting:"){bucket_sort2(ary)}
  x.report("heap_sort:"){heap_sort(ary)}
end
