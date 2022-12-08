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

class Test_Day_9 < Minitest::Test
  def test_calculate_part1
    assert_equal(1, Main.new(File.open('day9-example.txt')).calculate_part1)
  end

  def test_calculate_part2
    assert_equal(2, Main.new(File.open('day9-example.txt')).calculate_part2)
  end
end

puts "Day9 Part1 Example: #{Main.new(File.open('day9-example.txt').read).calculate_part1}"
puts "Day9 Part2 Example: #{Main.new(File.open('day9-example.txt').read).calculate_part2}"
puts "Day9 Part1 Input: #{Main.new(File.open('day9-input.txt').read).calculate_part1}"
puts "Day9 Part2 Input: #{Main.new(File.open('day9-input.txt').read).calculate_part2}"
