

def space_written_ruby(*arrays)
  flattened = []
  min,max = arrays[0][0], arrays[0][0]
  arrays.each do |array|
    array.each do |value|
      min = value if value < min
      max = value if value > max
      flattened << value
    end
  end
  count_hash = (min..max).each_with_object({}){ |i, result| result[i] = 0 }
  flattened.each{|ele| count_hash[ele] += 1}
  memo = 0
  #sums elements up to sort
  count_hash.keys.each{|ele|
    count_hash[ele] += memo
    memo = count_hash[ele]
  }
  sorted = Array.new(flattened.size)
  #sort by adding to empty array using values in count_hash
  flattened.each{|x|
    sorted[count_hash[x]] = x
    count_hash[x] -= 1
  }
  sorted.compact
end

# space_written_ruby([3,6,1],[2,9,8],[5,4,7]) == [1,2,3,4,5,6,7,8,9]
