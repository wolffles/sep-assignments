# this one utilizes the standard bucket_sort
def bucket_sort2(array)
  # push value into buckets index
  divider = array.size * 0.1 #divides into 10 buckets
  bucket = (0..10).map{|i| [i,[]]}.to_h
  #hash_key = (value / divider)
  array.each{|ele| bucket[(ele/divider).floor] << ele}
  (0..10).each do |x|
    min = (x * divider).floor
    max = ((x + 1) * divider).ceil
    if !bucket[x].nil?
      bucket[x] = counting_sort2(bucket[x], min, max)
    end
  end
    bucket.values.flatten
end

def counting_sort2(array,min,max)
  #preprocessed nil arrays, you dont have to worry about it dealing with it.
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
  #sort by adding to empty array using values in array
  array.each{|x|
    sorted[count_hash[x]] = x
    count_hash[x] -= 1
  }
  sorted.compact
end

# array = (1..40).to_a.shuffle
# p bucket_sort2(array)
# p bucket_sort2(array) == (1..40).to_a
