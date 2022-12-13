class Main
  attr_reader :input
  require 'json'
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
  end

  def compare(left, right)
    return if left.empty? && right.empty?
    return true if left.empty?
    return false if right.empty?
    heads = [left.first, right.first]
    case heads
    in [Integer, Integer]
      return true if heads.reduce(:<)
      return false if heads.reduce(:>)
    else
      heads.map! { |i| i.instance_of?(Integer) ? [i] : i }
      comp = compare(heads[0], heads[1])
      return comp if [true, false].include? comp
    end
    compare(left.slice(1..), right.slice(1..))
  end

  def calculate_part1
    input.split("\n\n").map { |i| i.split("\n") }
         .map { |i| i.map { |j| JSON.parse(j) } }
         .map.with_index(1) { |(l, r), i| compare(l, r) ? i : 0 }
      .sum
  end

  def calculate_part2
    dividers = [2, 6].map { |i| [i] }
    packets = [nil] + input.split("\n\n")
                           .map { |i| i.gsub('[]', '[0]') }
                           .map { |i| i.split("\n") }
                           .map { |i| i.map { |j| JSON.parse(j) } }
                           .reduce([]) { |acc, (i, j)| acc << i << j }
                        .concat(dividers)
                        .sort_by(&:flatten)
    dividers.map { |i| packets.index(i) }.reduce(:*)
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

puts "DayX Part1 Example: #{Main.new(File.open('./input/day13-example.txt').read).calculate_part1}"
puts "DayX Part2 Example: #{Main.new(File.open('./input/day13-example.txt').read).calculate_part2}"
puts "DayX Part1 Input: #{Main.new(File.open('./input/day13-input.txt').read).calculate_part1}"
puts "DayX Part2 Input: #{Main.new(File.open('./input/day13-input.txt').read).calculate_part2}"
