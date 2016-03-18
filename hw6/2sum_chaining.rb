require 'prime'
def two_sum2(array)
  output_pair_num = 0
  output_pair = []
  hash_table, hash_size = create_hash_table_bucket(array)
  (0..array.length - 1).each do |i|
    target_1 = -10_000 - array[i]
    target_2 = 10_000 - array[i]
    target_1_index = (target_1.abs / 10_000) % hash_size
    target_2_index = (target_2.abs / 10_000) % hash_size
    if target_1_index > target_2_index
      target_low_index = target_2_index
      target_high_index = target_1_index
    else
      target_high_index = target_2_index
      target_low_index = target_1_index
    end
    (target_low_index..target_high_index).each do |j|
      hash_table[j].each do |k|
        if k + array[i] >= -10_000 && k + array[i] <= 10_000 && !output_pair.include?(k + array[i])
          output_pair_num += 1
          output_pair << k + array[i]
        end
      end
    end
  end
  output_pair_num
end

def create_hash_table_bucket(array)
  target = 10_000
  hash_size = check_prime(31_111)
  hash_table = []
  (0..hash_size - 1).each do |i|
    hash_table[i] = []
  end
  (0..array.length - 1).each do |i|
    index = (array[i].abs / target) % hash_size
    hash_table[index] << array[i]
  end
  [hash_table, hash_size]
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
