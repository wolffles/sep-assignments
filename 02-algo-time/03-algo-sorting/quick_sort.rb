
def swap(array, firstIndex, secondIndex)
  temp = array[firstIndex]
  array[firstIndex] = array[secondIndex]
  array[secondIndex] = temp;
end

#divides array given into sub arrays
#variables:
  #p: beginning index of array/subarray
  #r: ending index of array/subarray
  #q: middle of the index
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

# ary = (1..1000).to_a.shuffle
# p quick_sort(ary,0,ary.size-1)
# p quick_sort(ary,0,ary.size-1) == (1..1000).to_a
