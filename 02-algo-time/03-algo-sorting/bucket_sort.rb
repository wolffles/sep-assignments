#this code utilizes my own hash_sort
def bucket_sort(array)
  divider = array.size * 0.1 # divides into 10 buckets, think 10%
  bucket = (0..10).map{|i| [i,[]]}.to_h
  #hash_key = (value / divider)
  array.each{|ele| bucket[(ele/divider).floor] << ele}
  (0..10).each do |x|
    min = (x * divider).floor
    max = ((x + 1) * divider).ceil
    if !bucket[x].nil?
      bucket[x] = hash_sort(bucket[x], min, max)
    end
  end
    bucket.values.flatten
end

#by having a sequential range and creating a hash out of it, we can push into hash values
def hash_sort(array, min, max)
  sorted_hash = (min..max).map{|i| [i, []]}.to_h
  array.each{|ele| sorted_hash[ele] << ele}
  sorted_hash.values.flatten
end
#
# array = (1..40).to_a.shuffle
# p bucket_sort(array)
#p bucket_sort(array) == (1..40).to_a
