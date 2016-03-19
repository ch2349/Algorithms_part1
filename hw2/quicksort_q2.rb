@comparison = 0
def quicksort(array, start, ended)
  if start < ended
    p_index = partition_end(array, start, ended)
    quicksort(array, start, p_index - 1)
    quicksort(array, p_index + 1, ended)
  end
  array
end

def partition_end(array, start, ended)
  i = start + 1
  array[start], array[ended] = array[ended], array[start]
  piv = array[start]
  @comparison += (ended - start)
  ((start + 1)..ended).each do |j|
    if array[j] < piv
      array[j], array[i] = array[i], array[j]
      i += 1
    end
  end
  array[i - 1], array[start] = array[start], array[i - 1]
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
