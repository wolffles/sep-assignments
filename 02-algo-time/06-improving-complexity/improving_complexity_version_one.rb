#code optimization: Code can be optimized by pruning unused statements, assignments, or adding shortcuts such as ending a loop early if possible.

# This method takes n arrays as input and combine them in sorted ascending order
require 'byebug'

def optimize_written_ruby(*arrays)
  combined_array = []
  arrays.each do |array|
    array.each do |value|
      combined_array << value
    end
  end

  sorted_array = [combined_array.delete_at(combined_array.length-1)]

  for val in combined_array
    # byebug
    i = 0
    i = 0
    while i < sorted_array.length
      if val <= sorted_array[i]
          sorted_array.insert(i, val)
          break
        end
        i+=1
      end
      if i == sorted_array.length
        sorted_array << val
      end
    end

  # Return the sorted array\
  # puts sorted_array
  sorted_array
end


# optimize_written_ruby([3,6,1],[2,9,8],[5,4,7])
