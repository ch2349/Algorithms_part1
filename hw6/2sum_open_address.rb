require 'prime'
def two_sum2(array)
  output_pair_num = 0
  output_pair = []
  hash_table, hash_func = create_hash_table_bucket(array)
  (0..array.length - 1).each do |i|
    target_1 = -10_000 - array[i]
    target_2 = 10_000 - array[i]
    target_1_index = (target_1.abs / 10_000) % hash_func
    target_2_index = (target_2.abs / 10_000) % hash_func
    target_low_index = if target_1_index > target_2_index
                         target_2_index
                       else
                         target_1_index
                       end
    (target_low_index..hash_table.length - 1).each do |j|
      break if hash_table[j] == []
      if hash_table[j] + array[i] >= -10_000 && hash_table[j] + array[i] <= 10_000 && !output_pair.include?(hash_table[j] + array[i])
        output_pair_num += 1
        output_pair << hash_table[j] + array[i]
      end
    end
  end
  output_pair_num
end

def create_hash_table_bucket(array)
  target = 10_000
  hash_func = check_prime(1_111_110)
  hash_size = 1_112_000
  hash_table = []
  (0..hash_size - 1).each do |i|
    hash_table[i] = []
  end
  (0..array.length - 1).each do |i|
    index = (array[i].abs / target) % hash_func
    added = false
    while added == false
      if hash_table[index] == []
        hash_table[index] = array[i]
        added = true
      else
        index += 1
      end
    end
  end
  [hash_table, hash_func]
end

def check_prime(value)
  return value if Prime.prime?(value)
  check_prime(value + 1)
end

a = []
i = 0
File.open('/Users/chen-chouhsieh/Desktop/algorithms/algorithm1/algo1_programming_prob_2sum.txt', 'r') do |f|
  f.each_line do |line|
    a[i] = line.to_i
    i += 1
  end
end
puts two_sum2(a)
