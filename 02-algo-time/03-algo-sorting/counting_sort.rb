def counting_sort(array)
  min = array[0]
  max = array[0]
  array.each{|ele|
    min = ele if ele < min
    max = ele if ele > max
  }
  count_hash = (min..max).each_with_object({}){ |i, result| result[i] = 0 }
  #counts each element
  array.each{|ele| count_hash[ele] += 1}
  memo = 0
  #sums elements up to sort
  count_hash.keys.each{|ele|
    count_hash[ele] += memo
    memo = count_hash[ele]
  }
  sorted = Array.new(array.size)
  #sort by adding to empty array using values in count_hash
  array.each{|x|
    sorted[count_hash[x]] = x
    count_hash[x] -= 1
  }
  sorted.compact
end
#
# array = (1..40).to_a.shuffle
# p counting_sort(array)
# p counting_sort(array) == (1..40).to_a
