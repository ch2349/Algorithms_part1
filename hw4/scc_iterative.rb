def scc_iterative(arrays)
  scc = []
  finished_time = []
  graph_list = array_to_graph(arrays)
  dfs_iterative(graph_list, false, finished_time, scc)
  array_finished = array_rename_with_finish_time_rev(arrays, finished_time)
  dfs_iterative(array_finished, true, finished_time, scc)
  scc.sort!
  scc.reverse!
  [scc[0], scc[1], scc[2], scc[3], scc[4]]
end

def dfs_iterative(array, second_round, finished_time, scc)
  t = 0
  last_vertex = array.last[0][0]
  visited = []
  finished = []
  stack = []
  check = 0
  (0..last_vertex - 1).each do |i|
    finished[i] = false
  end
  (0..last_vertex - 1).each do |i|
    visited[i] = false
  end
  last_vertex.downto(1).each do |vertex|
    stack << vertex
    while stack.count != 0
      vertex_i = stack.pop
      if !visited[vertex_i - 1]
        visited[vertex_i - 1] = true
        check += 1 if second_round == true
        stack << vertex_i
        (0..array[vertex_i - 1].length - 1).each do |i|
          unless visited[array[vertex_i - 1][i][1] - 1]
            stack << array[vertex_i - 1][i][1]
          end
        end
      elsif !finished[vertex_i - 1]
        finished[vertex_i - 1] = true
        t += 1
        finished_time[vertex_i - 1] = t
      end
    end
    if second_round == true
      scc << check
      check = 0
    end
  end
end

# [1,1] will put in array[0]
def array_to_graph(arrays)
  last_vertex = arrays.last[0]
  graph_list = []
  (0..last_vertex - 1).each do |i|
    graph_list[i] = []
  end
  arrays.each do |array|
    graph_list[array[0] - 1] << array
  end
  graph_list
end

def array_rename_with_finish_time_rev(array_a_s, finished_time)
  array_new = []
  (0..array_a_s.last[0] - 1).each do |i|
    array_new[i] = []
  end
  array_a_s.each do |array_a|
    a = []
    array_a.each do |item|
      a << finished_time[item - 1]
    end
    a[0], a[1] = a[1], a[0]
    array_new[a[0] - 1] << a
  end
  (0..array_new.length - 1).each do |i|
    array_new[i] << [i + 1, i + 1] if array_new[i] == []
  end
  array_new
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop/algorithms/algorithm1/SCC.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.gsub(" \n", ' ').split(' ').map(&:to_i)
    i += 1
  end
end

puts scc_iterative(a)
