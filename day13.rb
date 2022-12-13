class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input.split("\n\n")
    @good_indices = @input.each_with_index.map do |pair, index|
      x, y = pair.split("\n").map { eval(_1) }
      ordered(x, y) * (index + 1)
    end
    @sorted_pairs = @input.map { _1.split("\n").map { |l| eval(l) } }.reduce(&:+).concat([[[2]], [[6]]]).sort { |a, b| ordered(b, a) * 2 - 1 }
  end

  def ordered(a, b)
    if a.class == Integer && b.class == Integer
      return a > b ? 0 : b > a ? 1 : nil
    else
      a = [a] if a.class != Array
      b = [b] if b.class != Array
      l = [a.length, b.length].min
      (0...l).each { |i| return ordered(a[i], b[i]) if ordered(a[i], b[i]) }
      return a.length > b.length ? 0 : b.length > a.length ? 1 : nil
    end
  end

  def calculate_part1
    @good_indices.reduce(&:+)
  end

  def calculate_part2
    (@sorted_pairs.find_index([[2]]) + 1) * (@sorted_pairs.find_index([[6]]) + 1)
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 13
    assert_equal(test_case, Main.new(File.open('./input/day13-example.txt').read).calculate_part1)
  end

  def test_calculate_part2
    test_case = 140
    assert_equal(test_case, Main.new(File.open('./input/day13-example.txt').read).calculate_part2)
  end

  def test_calculate_part3
    test_case = 5390
    assert_equal(test_case, Main.new(File.open('./input/day13-input.txt').read).calculate_part1)
  end

  def test_calculate_part4
    test_case = 19261
    assert_equal(test_case, Main.new(File.open('./input/day13-input.txt').read).calculate_part2)
  end
end

puts "Day13 Part1 Example: #{Main.new(File.open('./input/day13-example.txt').read).calculate_part1}"
puts "Day13 Part2 Example: #{Main.new(File.open('./input/day13-example.txt').read).calculate_part2}"
puts "Day13 Part1 Input: #{Main.new(File.open('./input/day13-input.txt').read).calculate_part1}"
puts "Day13 Part2 Input: #{Main.new(File.open('./input/day13-input.txt').read).calculate_part2}"
