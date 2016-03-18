# use binary to store the input.
# all items smaller than root then put them left leaf
# all items larger than root then put them in the right leaf
# item = [key, self_position, left_child_position, right_child_position, parent_position]
def median_maintain(array)
  bst = []
  rtree_size = 0
  ltree_size = 0
  bst[0] = [array[0], 0, nil, nil, nil]
  median = [array[0]]
  (1..array.count - 1).each do |i|
    if array[i] > bst[0][0]
      rtree_size += 1
      insert_by_search(array[i], bst)
      if rtree_size > ltree_size + 1
        new_key = bst[0][0]
        min = find_min_right_tree(bst[0], bst)
        link_parent_only_child(min, bst)
        bst[0][0] = min[0]
        bst[min[1]] = []
        max = find_max_left_tree(bst[0], bst)
        max = bst[0] if max.nil?
        insert_bst(new_key, max[1], bst)
        rtree_size -= 1
        ltree_size += 1
      end
    else
      ltree_size += 1
      insert_by_search(array[i], bst)
      if ltree_size > rtree_size + 1
        new_key = bst[0][0]
        max = find_max_left_tree(bst[0], bst)
        link_parent_only_child(max, bst)
        bst[0][0] = max[0]
        bst[max[1]] = []
        min = find_min_right_tree(bst[0], bst)
        min = bst[0] if min.nil?
        insert_bst(new_key, min[1], bst)
        ltree_size -= 1
        rtree_size += 1
      end
    end
    median << if rtree_size >= ltree_size
                bst[0][0]
              else
                find_max_left_tree(bst[0], bst)[0]
              end
  end
  sum = 0
  (0..median.count - 1).each do |i|
    sum += median[i]
  end
  sum % 10_000
end

def insert_by_search(key, bst)
  node, parent_position = search_bst(key, bst[0], bst)
  if node.nil?
    insert_bst(key, parent_position, bst)
  else
    insert_dup_bst(key, bst[node[2]], bst)
  end
end

def search_bst(key, node, bst)
  current_node = node
  until current_node.nil?
    return [current_node, nil] if key == current_node[0]
    if key < current_node[0]
      if !current_node[2].nil?
        current_node = bst[current_node[2]]
      else
        parent_position = current_node[1]
        current_node = nil
      end
    else
      if !current_node[3].nil?
        current_node = bst[current_node[3]]
      else
        parent_position = current_node[1]
        current_node = nil
      end
    end
  end
  [current_node, parent_position]
end

def insert_bst(key, parent_position, bst)
  new_node = [key, bst.length, nil, nil, parent_position]
  bst << new_node
  if key < bst[parent_position][0]
    bst[parent_position][2] = bst.length - 1
  else
    bst[parent_position][3] = bst.length - 1
  end
end

def insert_dup_bst(key, node, bst)
  current_node = node
  until current_node.nil?
    if key <= current_node[0]
      if current_node[2].nil?
        parent_position = current_node[1]
        current_node = nil
      else
        current_node = bst[current_node[2]]
      end
    else
      if current_node[3].nil?
        parent_position = current_node[1]
        current_node = nil
      else
        current_node = bst[current_node[3]]
      end
    end
  end
  insert_bst(key, parent_position, bst)
end

def link_parent_only_child(node, bst)
  parent_node = bst[node[4]]
  if node[2].nil? && node[3].nil?
    if parent_node[2] == node[1]
      parent_node[2] = nil
    elsif parent_node[3] == node[1]
      parent_node[3] = nil
    end
    return
  end
  if node[2].nil?
    child_node = bst[node[3]]
  elsif node[3].nil?
    child_node = bst[node[2]]
  end
  # link the parent to the child
  if parent_node[2] == node[1]
    parent_node[2] = child_node[1]
    child_node[4] = parent_node[1]
  elsif parent_node[3] == node[1]
    parent_node[3] = child_node[1]
    child_node[4] = parent_node[1]
  end
end

def find_min_right_tree(node, bst)
  unless node[3].nil?
    next_node = bst[node[3]]
    until next_node.nil?
      if !next_node[2].nil?
        next_node = bst[next_node[2]]
      else
        current_node = next_node
        next_node = nil
      end
    end
    return current_node
  end
end

def find_max_left_tree(node, bst)
  unless node[2].nil?
    next_node = bst[node[2]]
    until next_node.nil?
      if !next_node[3].nil?
        next_node = bst[next_node[3]]
      else
        current_node = next_node
        next_node = nil
      end
    end
    return current_node
  end
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
