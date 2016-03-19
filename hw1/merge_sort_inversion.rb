@total_inv = 0
def merge_sort(array)
  return array if array.count < 2
  mid = array.count / 2
  left_array = array.slice(0, mid)
  right_array = array.slice(mid, array.count - mid)
  array_1 = merge_sort(left_array)
  array_2 = merge_sort(right_array)
  merge(array_1, array_2)
end

def merge(array_1, array_2)
  array = []
  i = 0
  j = 0
  while i < array_1.count && j < array_2.count
    if array_1[i] < array_2[j]
      array << array_1[i]
      i += 1
    else
      array << array_2[j]
      j += 1
      @total_inv += (array_1.count - i)
    end
  end
  while i < array_1.count
    array << array_1[i]
    i += 1
  end
  while j < array_2.count
    array << array_2[j]
    j += 1
  end
  array
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop/algorithms/algorithm1/IntegerArray.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.gsub("\r\n", '').to_i
    i += 1
  end
end

merge_sort(a)

puts @total_inv
