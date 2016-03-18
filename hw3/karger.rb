# https://codehiker.wordpress.com/2012/04/01/graph-min-cut-problem/
# Graph represented as adjacency lists:
# 1-2-3
# 2-1-3-4
# 3-1-2-4
# 4-2-3
# Next step, choose a random edge to contract,
# for instance edge (1,2), so we merge node 2 into node 1:
# Now, on the adjacency lists, we do 4 things:
# 1) attach node 2’s list to node 1’s
# 1-2-3-2-1-3-4
# 2-1-3-4
# 3-1-2-4
# 4-2-3
# 2) for 2’s adjacent nodes 1,3,4, scan their lists
# and replace all occurrence of 2 as 1
# 1-1-3-1-1-3-4
# 2-1-3-4
# 3-1-1-4
# 4-1-3
# 3)remove self-loops in 1’s list
# 1-3-3-4
# 2-1-3-4
# 3-1-1-4
# 4-1-3
# 4) remove 2’s list
# 1-3-3-4
# 3-1-1-4
# 4-1-3
# Now the remaining is what we want for this first step.
# Then next step will be a repeat of the process above.
# For example, choose (1,4) to contract,
# the remaining graph would be:
# the processed lists would be :
# 1-3-3-3
# 3-1-1-1

def karger(array)
  while array.length > 2
    verd = pick_edge(array)
    verd.sort!
    u = 'z'
    v = 'z'
    (0..array.length - 1).each do |i|
      u = i if array[i][0] == verd[0] && v == 'z'
      v = i if array[i][0] == verd[1] && u != 'z'
    end
    array[u].concat(array[v])
    replace(array, array[v][0], array[u][0])
    self_remove(array[u])
    array.delete_at(v)
  end
  array[0].count - 1
end

def pick_edge(array)
  index = rand(0..array.length - 1)
  u = array[index][0]
  a = []
  (1..array[index].length - 1).each do |i|
    a << array[index][i]
  end
  v = a.sample
  [u, v]
end

def replace(arrays, i, j)
  arrays.each do |array|
    array.map! { |x| x == i ? j : x }
  end
end

def self_remove(array)
  (1..array.length - 1).each do |i|
    array[i] = 0 if array[0] == array[i]
  end
  array.delete(0)
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop/algorithms/kargerMinCut.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.gsub("\t\r\n", '').split("\t").map(&:to_i)
    i += 1
  end
end

puts karger(a)
