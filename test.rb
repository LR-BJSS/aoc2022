cubes = File.open('./input/day18-input.txt').readlines.map { _1.split(',').map(&:to_i) }
puts 6 * cubes.size - 2 * cubes.combination(2).count{ |a, b| a.zip(b).sum{(_2-_1).abs} == 1 }
