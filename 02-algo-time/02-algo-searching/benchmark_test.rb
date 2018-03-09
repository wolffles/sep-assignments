require_relative 'fibonacci'
require_relative 'fibonnaci_recursive'
require 'benchmark'
n = 1000
puts "two fibs return same answer?: #{fib(n) == fib_recursive(n)}"
Benchmark.bm(7) do |x|
  x.report("iteration:"){fib(n)}
  x.report("recursion:"){fib_recursive(n)}
end
