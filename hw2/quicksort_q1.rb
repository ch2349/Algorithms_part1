@comparison = 0
def quicksort(array, index_first, index_ended)
  if index_first < index_ended
    p_index = partition(array, index_first, index_ended)
    quicksort(array, index_first, p_index - 1)
    quicksort(array, p_index + 1, index_ended)
  end
  array
end

def partition(array, index_first, index_ended)
  index_start = index_first + 1
  i = index_start
  piv = array[index_first]
  @comparison += (index_ended - index_first)
  (index_start..index_ended).each do |j|
    if array[j] < piv
      array[j], array[i] = array[i], array[j]
      i += 1
    end
  end
  array[index_first], array[i - 1] = array[i - 1], array[index_first]
  i - 1
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop/algorithms/algorithm1/QuickSort.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.gsub("\r\n", '').to_i
    i += 1
  end
end

quicksort(a, 0, a.length - 1)
puts @comparison
