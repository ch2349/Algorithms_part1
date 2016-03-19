@comparison = 0
def quicksort(array, start, ended)
  if start < ended
    p_index = partition_median(array, start, ended)
    quicksort(array, start, p_index - 1)
    quicksort(array, p_index + 1, ended)
  end
  array
end

def partition_median(array, start, ended)
  p_index = median(array, start, ended)
  array[p_index], array[start] = array[start], array[p_index]
  i = start + 1
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

def median(array, start, ended)
  length = ended - start + 1
  if length > 1
    k = []
    a = array[start]
    b = array[ended]
    c = if length.even?
          array[start + (length / 2) - 1]
        else
          array[start + (length - 1) / 2]
        end
    k[0] = a
    k[1] = b
    k[2] = c
    k.sort!
    return start if k[1] == array[start]
    return ended if k[1] == array[ended]
    return start + (length / 2) - 1 if length.even?
    start + (length - 1) / 2
  end
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
