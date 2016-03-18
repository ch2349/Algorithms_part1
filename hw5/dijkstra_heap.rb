def diks(array, vertex, total_vertex)
  min_heap = []
  inf = 999_999_999
  (0..total_vertex - 1).each do |i|
    # [vertex, dist] at vertex -1 position
    min_heap[i] = [i + 1, inf]
  end
  hash_table = []
  (0..total_vertex - 1).each do |i|
    # [ vertex , minheap position] at vertex -1 position
    hash_table[i] = [i + 1, i]
  end
  dist = []
  (0..total_vertex - 1).each do |i|
    dist[i] = inf
  end
  dist[vertex - 1] = 0
  decrease_dis(min_heap, hash_table, vertex, 0)
  0.upto(array.count - 1) do |_i|
    root = extract_min(min_heap, hash_table)
    u = root[0]
    (1..array[u - 1].length - 1).each do |j|
      if in_minheap?(min_heap, hash_table, array[u - 1][j][0]) == true && (dist[u - 1] + array[u - 1][j][1]) < dist[array[u - 1][j][0] - 1]
        dist[array[u - 1][j][0] - 1] = dist[u - 1] + array[u - 1][j][1]
        decrease_dis(min_heap, hash_table, array[u - 1][j][0], dist[u - 1] + array[u - 1][j][1])
      end
    end
  end
  [dist[6], dist[36], dist[58], dist[81], dist[98], dist[114], dist[132], dist[164], dist[187], dist[196]]
end

def decrease_dis(min_heap, hash_table, vertex, dist)
  # vertex position in minheap
  i = hash_table[vertex - 1][1]
  # update vertex's minheap dist
  min_heap[i][1] = dist
  # travel up the minheap if parent > child && not at the root
  while i != 0 && (min_heap[i][1] < min_heap[(i - 1) / 2][1])
    hash_table[min_heap[i][0] - 1][1] = (i - 1) / 2
    hash_table[min_heap[(i - 1) / 2][0] - 1][1] = i
    min_heap[i], min_heap[(i - 1) / 2] = min_heap[(i - 1) / 2], min_heap[i]
    i = (i - 1) / 2
  end
end

def extract_min(min_heap, hash_table)
  return 'null' if min_heap.empty?
  root = min_heap[0]
  new_root = min_heap.last
  hash_table[min_heap[0][0] - 1][1] = min_heap.length + 1
  min_heap.delete_at(0)
  min_heap.delete_at(-1)
  hash_table[new_root[0] - 1][1] = 0
  min_heap.unshift(new_root)
  heapify(min_heap, hash_table, 0)
  root
end

# heapify means balance the min_heap
def heapify(min_heap, hash_table, index)
  smallest = index
  left_child = 2 * index + 1
  right_child = 2 * index + 2
  if (left_child < min_heap.length) && (min_heap[left_child][1] < min_heap[smallest][1])
    smallest = left_child
  end
  if (right_child < min_heap.length) && (min_heap[right_child][1] < min_heap[smallest][1])
    smallest = right_child
  end
  if smallest != index
    hash_table[min_heap[index][0] - 1][1] = smallest
    hash_table[min_heap[smallest][0] - 1][1] = index
    min_heap[smallest], min_heap[index] = min_heap[index], min_heap[smallest]
    heapify(min_heap, hash_table, smallest)
  end
end

def in_minheap?(min_heap, hash_table, v)
  return true if hash_table[v - 1][1] < min_heap.length
  false
end

def file_to_graph
  a = []
  i = 0
  File.open('/Users/chen-chouhsieh/Desktop/algorithms/algorithm1/dijkstraData.txt', 'r') do |f|
    f.each_line do |line|
      a[i] = []
      k = 0
      line.gsub("\t\r\n", '').split("\t").map do |s|
        a[i][k] = if s.split(',').map(&:to_i).count > 1
                    s.split(',').map(&:to_i)
                  else
                    s.to_i
                  end
        k += 1
      end
      i += 1
    end
  end
  a
end
a = file_to_graph
puts diks(a, 1, 200)
