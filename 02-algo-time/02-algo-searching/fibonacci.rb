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
