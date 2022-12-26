class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
  end

  def calculate_part1
    1
  end

  def calculate_part2
    2
  end
end

class Test_Day_22 < Minitest::Test
  def test_calculate_part1
    test_case = 1
    assert_equal(test_case, Main.new(File.open('./input/day22-example.txt').read).calculate_part1)
  end

  def test_calculate_part2
    test_case = 2
    assert_equal(test_case, Main.new(File.open('./input/day22-example.txt').read).calculate_part2)
  end

  def test_calculate_part3
    test_case = 1
    assert_equal(test_case, Main.new(File.open('./input/day22-input.txt').read).calculate_part1)
  end

  def test_calculate_part4
    test_case = 2
    assert_equal(test_case, Main.new(File.open('./input/day22-input.txt').read).calculate_part2)
  end
end

puts "Day22 Part1 Example: #{Main.new(File.open('./input/day22-example.txt').read).calculate_part1}"
puts "Day22 Part2 Example: #{Main.new(File.open('./input/day22-example.txt').read).calculate_part2}"
puts "Day22 Part1 Input: #{Main.new(File.open('./input/day22-input.txt').read).calculate_part1}"
puts "Day22 Part2 Input: #{Main.new(File.open('./input/day22-input.txt').read).calculate_part2}"
