#fibonacci.rb

def fib(n)
	fib_0 = 0
	fib_1 = 1
	return 0 if n == 0
	for temp in 2..n
		temp = fib_0
		fib_0 = fib_1
		fib_1 = temp + fib_0
	end
	return fib_1
end
puts fib(0)
puts fib(0) == 0
puts fib(1)
puts fib(1) == 1
puts fib(2)
puts fib(2) == 1
puts fib(3)
puts fib(3) == 2
puts fib(4)
puts fib(4) == 3
puts fib(5)
puts fib(5) == 5
puts fib(6)
puts fib(6) == 8
puts fib(7)
puts fib(7) == 13
puts fib(8)
puts fib(8) == 21
puts fib(9)
puts fib(9) == 34
