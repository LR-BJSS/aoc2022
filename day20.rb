class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
  end

  def calculate_part1
    [1].each{|n|
      a = input.each_with_index.map{[_1.to_i * n, _2]}
      (1).times{a.size.times{|i| a.insert(
        ((j = a.index{_1[1] == i}) + a[j][0]) % (a.size - 1), a.delete_at(j))}}
      return [1, 2, 3].map{|x| a[(a.index{_1[0] == 0} + x * 1000) % a.size]}.sum{_1[0]}}
  end

  def calculate_part2
    [811589153].each{|n|
      a = input.each_with_index.map{[_1.to_i * n, _2]}
      (10).times{a.size.times{|i| a.insert(
        ((j = a.index{_1[1] == i}) + a[j][0]) % (a.size - 1), a.delete_at(j))}}
      return [1, 2, 3].map{|x| a[(a.index{_1[0] == 0} + x * 1000) % a.size]}.sum{_1[0]}}
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 3
    assert_equal(test_case, Main.new(File.open('./input/day20-example.txt').readlines).calculate_part1)
  end

  def test_calculate_part2
    test_case = 1623178306
    assert_equal(test_case, Main.new(File.open('./input/day20-example.txt').readlines).calculate_part2)
  end

  def test_calculate_part3
    test_case = 1087
    assert_equal(test_case, Main.new(File.open('./input/day20-input.txt').readlines).calculate_part1)
  end

  def test_calculate_part4
    test_case = 13084440324666
    assert_equal(test_case, Main.new(File.open('./input/day20-input.txt').readlines).calculate_part2)
  end
end

puts "Day20 Part1 Example: #{Main.new(File.open('./input/day20-example.txt').readlines).calculate_part1}"
puts "Day20 Part2 Example: #{Main.new(File.open('./input/day20-example.txt').readlines).calculate_part2}"
puts "Day20 Part1 Input: #{Main.new(File.open('./input/day20-input.txt').readlines).calculate_part1}"
puts "Day20 Part2 Input: #{Main.new(File.open('./input/day20-input.txt').readlines).calculate_part2}"
