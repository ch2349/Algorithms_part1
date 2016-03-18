# use max heap and min heap to store the input.
# smaller numbers put in the maxheap and larger numbers put in minheap.
# when the input larger than the max of maxheap then put it in minheap
# when the input smaller than the min of minheap then put it in the maxheap
# when the number in the minheap is equal to the number in the maxheap
# the median will be the max of maxheap
# when the number is odd
# the median will be the max of max heap or min of minheap depends on
# which heap has more data
def median_maintain(array)
  max_heap = []
  min_heap = []
  if array[0] > array[1]
    max_heap = [array[1]]
    min_heap = [array[0]]
  else
    max_heap = [array[0]]
    min_heap = [array[1]]
  end
  m = [array[0], max_heap[0]]
  (2..array.count - 1).each do |i|
    if array[i] > max_heap[0]
      min_heap << array[i]
      balance_min(min_heap, min_heap.count - 1)
      if min_heap.count > max_heap.count + 1
        max_heap << min_heap[0]
        extract_min(min_heap)
        balance_max(max_heap, max_heap.count - 1)
      end
    else
      max_heap << array[i]
      balance_max(max_heap, max_heap.count - 1)
      if max_heap.count > min_heap.count + 1
        min_heap << max_heap[0]
        extract_max(max_heap)
        balance_min(min_heap, min_heap.count - 1)
      end
    end
    m << if max_heap.count == min_heap.count
           max_heap[0]
         elsif max_heap.count > min_heap.count
           max_heap[0]
         else
           min_heap[0]
         end
  end
  sum = 0
  (0..m.count - 1).each do |i|
    sum += m[i]
  end
  sum % 10_000
end

def balance_min(array, index)
  return if satisfied_parent_min?(array, index)
  array[parent(index)], array[index] = array[index], array[parent(index)]
  balance_min(array, parent(index))
end

def balance_max(array, index)
  return if satisfied_parent_max?(array, index)
  array[parent(index)], array[index] = array[index], array[parent(index)]
  balance_max(array, parent(index))
end

def satisfied_parent_min?(array, index)
  array[index] >= array[parent(index)]
end

def satisfied_parent_max?(array, index)
  array[index] <= array[parent(index)]
end

def parent(index)
  return 0 if index == 0
  return (index - 2) / 2 if index.even? && index != 0
  (index - 1) / 2
end

def extract_max(max_heap)
  max_heap.delete_at(0)
  max_heap.unshift(max_heap.last)
  max_heap.delete_at(max_heap.count - 1)
  bubble_down_max(max_heap, 0)
end

def extract_min(min_heap)
  min_heap.delete_at(0)
  min_heap.unshift(min_heap.last)
  min_heap.delete_at(min_heap.count - 1)
  bubble_down_min(min_heap, 0)
end

def bubble_down_min(array, index)
  return if satisfied_min?(array, index)
  smaller_child_index = assign_smaller_child(array, index)
  array[index], array[smaller_child_index] = array[smaller_child_index], array[index]
  bubble_down_min(array, smaller_child_index)
end

def bubble_down_max(array, index)
  return if satisfied_max?(array, index)
  larger_child_index = assign_larger_child(array, index)
  array[index], array[larger_child_index] = array[larger_child_index], array[index]
  bubble_down_max(array, larger_child_index)
end

def satisfied_max?(array, index)
  left_child_index = 2 * index + 1
  right_child_index = 2 * index + 2
  return true if leaf_node?(array, index)
  if array.length - 1 >= left_child_index && array.length - 1 >= right_child_index
    return array[index] >= array[left_child_index] && array[index] >= array[right_child_index]
  else
    return array[index] >= array[left_child_index]
  end
end

def satisfied_min?(array, index)
  left_child_index = 2 * index + 1
  right_child_index = 2 * index + 2
  return true if leaf_node?(array, index)
  if array.length - 1 >= left_child_index && array.length - 1 >= right_child_index
    return array[index] <= array[left_child_index] && array[index] <= array[right_child_index]
  else
    return array[index] <= array[left_child_index]
  end
end

def leaf_node?(array, index)
  index >= array.length / 2
end

def assign_larger_child(array, index)
  left_child_index = 2 * index + 1
  right_child_index = 2 * index + 2
  if array.length - 1 >= left_child_index && array.length - 1 >= right_child_index
    larger_child_index = if array[left_child_index] > array[right_child_index]
                           left_child_index
                         else
                           right_child_index
                         end
  else
    larger_child_index = left_child_index
  end
  larger_child_index
end

def assign_smaller_child(array, index)
  left_child_index = 2 * index + 1
  right_child_index = 2 * index + 2
  if array.length - 1 >= left_child_index && array.length - 1 >= right_child_index
    smaller_child_index = if array[left_child_index] > array[right_child_index]
                            right_child_index
                          else
                            left_child_index
                          end
  else
    smaller_child_index = left_child_index
  end
  smaller_child_index
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop//algorithms/algorithm1/Median.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.gsub("\r\n", '').to_i
    a[i] = line.to_i
    i += 1
  end
end

puts median_maintain(a)
