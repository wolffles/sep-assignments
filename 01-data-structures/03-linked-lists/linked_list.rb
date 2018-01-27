require_relative 'node'
require 'benchmark'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    if self.tail == nil
      self.tail = node
      self.head = node
    else
      self.tail.next = node
      self.tail = node
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if self.tail == self.head
      self.tail,self.head = nil,nil
    else
      current = self.head
      until current.next == self.tail
        current = current.next
      end
      current.next = nil
      self.tail = current
    end
  end

  # This method prints out a representation of the list.
  def print
    string = "#{self.head.data}\n"
    current = self.head
    until current == self.tail
      current = current.next
      string +="#{current.data}\n"
    end
    puts string
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if node == self.tail
      remove_tail
    elsif node == self.head
      remove_front
    else
      current = self.head
      until current.next == node
        current = current.next
      end
      look_ahead = current.next
      current.next = look_ahead.next
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    if self.head == nil
      self.tail = node
      self.head = node
    else
      temp = self.head
      self.head = node
      self.head.next = temp
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    temp = self.head.next
    self.head = nil
    self.head = temp
  end
end

n = 10000
ll = LinkedList.new
ary = Array.new(n).map!.with_index{|ele,y| Node.new(y)}
n1 = Node.new(5000)

Benchmark.bm(7) do |x|
  x.report("array"){ Array.new(n).map!.with_index{|ele,y| Node.new(y)}}
  x.report("linked list"){n.times{|i|
    if i = 5000
      ll.add_to_tail(n1)
    else
     ll.add_to_tail(Node.new(i))
   end}}
  x.report("array access 5000"){ ary.delete_at(5000)}
  x.report("5000 linked list"){ ll.delete( n1) }
end
