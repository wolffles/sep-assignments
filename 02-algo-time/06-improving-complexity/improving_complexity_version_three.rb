
def swap(array, firstIndex, secondIndex)
  temp = array[firstIndex]
  array[firstIndex] = array[secondIndex]
  array[secondIndex] = temp;
end

def partition(array, p, r)
  q = p
  j = p
  while j <= r-1
    if array[j] <= array[r]
      swap(array,q,j)
      q += 1
    end
      j += 1
  end
  swap(array,q,r)
  q
end

def quick_sort(array,p,r)

  if 0 < r-p
    q = partition(array,p,r);
    quick_sort(array,p,q-1);
    quick_sort(array,q+1,r);
  end
  return array
end

def space_written_ruby(*arrays)
  size = arrays.size
  size.times do
    arrays += arrays.shift
  end

  quick_sort(arrays , 0, arrays.size-1)
end

# space_written_ruby([3,6,1],[2,9,8],[5,4,7]) == [1,2,3,4,5,6,7,8,9]
