def min_bubble(array, index)
  return nil if index == 0
  parent = (index-1)/2
  if array[index] < array[parent]
    temp = array[index]
    array[index] = array[parent]
    array[parent] = temp
    min_bubble(array, parent)
  end
  return array
end

def heapify(array, index)
  left = array[(index * 2 + 1)]
  right = array[(index * 2 + 2)]
  current = array[index]
  if !left && !right
    nil
  elsif left && !right
    if left < current
      temp = array[index]
      array[index] = array[(index * 2 + 1)]
      array[(index * 2 + 1)] = temp
    end
  elsif left < current || right < current
    if left <= right
      temp = array[index]
      array[index] = left
      array[(index * 2 + 1)] = temp
      array = heapify(array, (index * 2 + 1))
    elsif right < left
      temp = array[index]
      array[index] = right
      array[(index * 2 + 2)] = temp
      array = heapify(array, (index * 2 + 2))
    end
  end
  array
end

def my_heap_sort(array)
  tree = []
  until array.empty?
    tree.push(array.shift)
    if tree.size > 1
      tree = min_bubble(tree, tree.size-1)
    end
  end
  sorted = []
  until tree.empty?
    sorted.push(tree[0])
    if tree.size > 1
      tree[0] = tree.pop
      tree = heapify(tree, 0)
    else
      tree.pop
    end
  end
  sorted
end

# ary = (1..10).to_a.shuffle
# p heap_sort(ary) == (1..10).to_a

#left child = index * 2 + 1
#right child = index * 2 + 1
#parent = (index - 1)/2
