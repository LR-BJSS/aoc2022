[1, 811589153].each{|n|
  a = File.readlines('./input/day20-input.txt').each_with_index.map{[_1.to_i * n, _2]}
  (n % 71).times{a.size.times{|i| a.insert(
    ((j = a.index{_1[1] == i}) + a[j][0]) % (a.size - 1), a.delete_at(j))}}
  p [1, 2, 3].map{|x| a[(a.index{_1[0] == 0} + x * 1000) % a.size]}.sum{_1[0]}}
