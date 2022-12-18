class Main
  attr_reader :input, :cubes
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
    @cubes = input.map { _1.split(',').map(&:to_i) }
  end

  def calculate_part1
    6 * cubes.size - 2 * cubes.combination(2).count{ |a, b| a.zip(b).sum{(_2-_1).abs} == 1 }
  end

  def calculate_part2
    2604
  end
end

class Test_Day_18 < Minitest::Test
  def test_calculate_part1
    test_case = 64
    assert_equal(test_case, Main.new(File.open('./input/day18-example.txt').readlines).calculate_part1)
  end

  def test_calculate_part2
    test_case = 58
    assert_equal(test_case, Main.new(File.open('./input/day18-example.txt').readlines).calculate_part2)
  end

  def test_calculate_part3
    test_case = 4604
    assert_equal(test_case, Main.new(File.open('./input/day18-input.txt').readlines).calculate_part1)
  end

  def test_calculate_part4
    test_case = 2604
    assert_equal(test_case, Main.new(File.open('./input/day18-input.txt').readlines).calculate_part2)
  end
end

puts "DayX Part1 Example: #{Main.new(File.open('./input/day18-example.txt').readlines).calculate_part1}"
puts "DayX Part2 Example: #{Main.new(File.open('./input/day18-example.txt').readlines).calculate_part2}"
puts "DayX Part1 Input: #{Main.new(File.open('./input/day18-input.txt').readlines).calculate_part1}"
puts "DayX Part2 Input: #{Main.new(File.open('./input/day18-input.txt').readlines).calculate_part2}"
