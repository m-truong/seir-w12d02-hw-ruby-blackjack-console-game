
## Data structures with Ruby - Linked list

A linked list is a way to store a collection of elements. Like an array these can be character or integers. Each element in a linked list is stored in the form of a node. A node is a collection of two sub-elements or parts. A data part that stores the element and a next part that stores the link to the next node.

<p align="center">
<img src="classes2-img4.png" width="200"> <br>
</p>

A linked list is formed when many such nodes are linked together to form a chain. Each node points to the next node present in the order. The first node is always used as a reference to traverse the list and is called HEAD. The last node points to NULL.

<p align="center">
<img src="classes2-img5.png" width="600"> <br>
</p>

```ruby
# Full list and methods
class LinkedList
    # gets-sets :head-:tail nodes
    # adds :size property for length of SLL 
    attr_accessor :head, :tail, :size 
  
  # SLL initialized with head-nil and tail-nil
  # size of SLL is 0 
    def initialize
      @head = nil
      @tail = nil
      @size = 0
    end
  
    # this append values to the end of the SLL
    # append-method adds new Node-object-instance to end of SLL object
    def append(value)
    # instantiates new Node-object and passes in value  
      node = Node.new(value)
      # increments @size instance of SLL object by one
      @size += 1

      # hits this if statement once 
      # checks if has head Node yet
      if @head.nil?
        @head = node
      else
      # calling next_node property on the existing-Node
      # sets equal to new Node object 
        @tail.next_node = node
      end

      # assumes that the tail is also the same Node? 
      @tail = node
    end
  
    # Adds a new node to the start of the list.
    def prepend(value)
      node = Node.new(value)
      @size += 1
  
      if @head.nil?
        @tail = node
      else
        node.next_node = @head
      end
    # changes the 'pointers' so that the @head is this new node 
      @head = node
    end
  
    # Returns the node at the given index.
    def at(index)
    # traversal 
        travel = @head
        # pass in num <= length of SLL
        if index <= @size
          # traverses the nodes by reasisnging the travel-node to the next-node
            0.upto(index - 1) do |i|
                travel = travel.next_node
            end
            # explicit return of the traveled-to node 
            return travel
        else
            return nil
        end
    end

  
    # Inserts the data at the given index.
    def insert_at(index, value)
    # newNode to insert 
        newNode = Node.new(value)
        
        travel = @head
        trail = nil
        if index <= @size
            0.upto(index - 1) do |i|
            # this maintains pointers
                trail = travel
                # keeps reassigning so that it doesn't lose the Nodes 'pointers' 
                travel = travel.next_node
            end
            # this connects the Nodes 
            trail.next_node = newNode
            # insert newNode inbetween the 'trailing node' and 'travel node' 
            newNode.next_node = travel
            @size += 1
        end
    end
  
    # Removes the data at the given index.
    def remove_at(index)
        travel = @head
        trail = nil
        if index <= @size
            0.upto(index - 1) do |i|
                trail = travel
                travel = travel.next_node
            end
            # this skips the SLL connection of the IN-BETWEEN node 
            # thus losing the reference pointer 
            # where does it go in memory though?
            trail.next_node = travel.next_node
            @size -= 1
        end
        
    end
  
    # Removes and returns the last element from the list.
    def pop
    # edgecase for if no nodes inserted into SLL yet 
    # prevents pop from executing 
    # checks if SLL has a tail-node then executes 
        if @tail != nil
        # stores to return the Node 
            old_tail = @tail

            # calls helper-function to get node previous to this one 
            new_tail = at(@size - 2)
            # changes the last-nodes.next-node to be nil 
            new_tail.next_node = nil

            # then changes the SLL @tail property to the new_tail Node 
            @tail = new_tail
            @size -= 1

            # outputs the old_tail Node 
            return old_tail
        end
    end
   
    # Returns true if the passed in value is in the list.
    def contains?(value)
        contains = false
        travel = @head
        while(travel != nil)
           if(travel.value == value)
            contains = true
           end
           travel = travel.next_node
        end
        return contains
    end
  
    # Returns the index of the node containing data, or nil if not found.
    # searches for the Node containing this (data) e.g. "string" or integer
    def find(data)
    # stores index, and returns index once found! 
        index = nil
        # "travelled-Node!"
        travel = @head
        0.upto(@size - 1) do |i|
        # Base-Case 
        # if travel-node value matches the 'data' searching for then it explicitly returns
            if(travel.value == data)
                index = i
            end
            travel = travel.next_node
        end
        # returns index 
        return index
    end
    #overload display
    # method overriding to_s in Ruby  
    def to_s
      string = ''
      # pushes all the nodes_values_to_s into the string 
      current_node = @head
      while(current_node != nil)
        string << current_node.value.to_s
        # pushes 'skinny-arrow' into string
        string << '->'
        # reassigns to next node 
        current_node = current_node.next_node
      end
      # adds 'nil'
      string << 'nil'
      # implicit return that returns the string variable 
      # # # # 
      string
    end
  end
```

```ruby
# Node structure.
class Node
  attr_accessor :value, :next_node

  def initialize(value = nil)
    @value = value
    @next_node = nil
  end
end
```

```ruby
# can just invoke the initializer() 
list = LinkedList.new

list.append(3)
list.append(5)
list.append(6)
list.prepend(1)
list.append(9)

puts list
p list.head
p list.tail

p list.at(3)
p list.contains?(9)
p list.find(9)
p list.find(10)

p list.size
p list.tail
p list.pop

p list.size
p list.tail
p list.pop

puts list
list.insert_at(2, 7)
puts list

list.insert_at(1, 11)
puts list

list.remove_at(1)
puts list

list.remove_at(2)
puts list
```
