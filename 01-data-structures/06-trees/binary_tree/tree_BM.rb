#benchmark tests for my trees
require_relative 'node'
require_relative 'binary_search_tree'
require_relative 'min_heap_tree'
require 'benchmark'

sample = (1..100000).to_a.shuffle.map{|ele| Node.new(ele.to_s,ele)}
n = 100000
root = Node.new("50000", 50000)
bi_tree = BinarySearchTree.new(root)
heap = MinHeapTree.new()
heap.insert(root)

del_samp = sample.sample(100000)


Benchmark.bm(7) do |x|
  x.report("binary tree: insertion"){n.times{|i| bi_tree.insert(root, sample[i])
    }
  }
  
  x.report("Heaptree: insertion"){n.times{|i| heap.insert( sample[i])
    }
  }

  x.report("binary tree: find array"){n.times{|i|
      bi_tree.find(root, del_samp[i].title)
    }
  }
  x.report("heap tree: find array"){n.times{|i|
      heap.find( del_samp[i].title)
    }
  }
  x.report("binary tree: delete"){n.times{|i|
      bi_tree.delete(root, del_samp[i].title)
    }
  }
  x.report("Heap tree: delete"){n.times{|i|
      heap.delete(del_samp[i].title)
    }
  }

end

#
# Benchmark.bm(7) do |x|
#   x.report("array"){ Array.new(n).map!.with_index{|ele,y| Node.new(y)}}
#   x.report("linked list"){n.times{|i|
#     if i = 5000
#       ll.add_to_tail(n1)
#     else
#      ll.add_to_tail(Node.new(i))
#    end}}
#   x.report("array access 5000"){ ary.delete_at(5000)}
#   x.report("5000 linked list"){ ll.delete( n1) }
# end
