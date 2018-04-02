require 'Benchmark'
require_relative 'poorly_written_ruby'
require_relative 'improving_complexity_version_one'
require_relative 'improving_complexity_version_two'
require_relative 'improving_complexity_version_three'
sorted = (1..9).to_a
if poorly_written_ruby([3,6,1],[2,9,8],[5,4,7]) == sorted &&
  optimize_written_ruby([3,6,1],[2,9,8],[5,4,7]) == sorted &&
  complexity_written_ruby([3,6,1],[2,9,8],[5,4,7]) == sorted &&
  space_written_ruby([3,6,1,2,9,8,5,4,7]) == sorted


  ary1 = (1..3000).to_a.shuffle
  ary2 = (3001..6000).to_a.shuffle
  ary3 = (6001..9000).to_a.shuffle
  array = [ary1,ary2,ary3].flatten
  Benchmark.bm(7) do |x|
    x.report("poor"){poorly_written_ruby(ary1,ary2,ary3)}
    x.report("pruning"){optimize_written_ruby(ary1,ary2,ary3)}
    x.report("complexity"){complexity_written_ruby(ary1,ary2,ary3)}
    x.report("space"){space_written_ruby(array)}
  end
else
  puts "some don't function properly."
end
