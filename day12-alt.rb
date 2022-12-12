class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
  end

  def find_next_steps(grid, heads, target, polarity, depth = 1)
    return if heads.empty?
    next_heads = []
    heads.each do |xh, yh|
      grid[yh][xh][:seen] = true
      steps = [[xh, yh + 1], [xh, yh - 1], [xh + 1, yh], [xh - 1, yh]]
                .reject { |x, y| x.negative? || y.negative? }
                .filter { |x, y| (x < grid.first.size) && (y < grid.size) }
                .reject { |x, y| grid[y][x][:seen].eql? true }
                .filter { |x, y| polarity * (grid[y][x][:h] - grid[yh][xh][:h]) < 2 }
      return depth if steps.map { |x, y| grid[y][x][:char] }.include? target
      next_heads += steps
    end
    find_next_steps(grid, next_heads.uniq, target, polarity, depth + 1)
  end

  def calculate_part1
    y = input.find_index { |i| i.include? 'S' }
    x = input[y].index('S')
    grid = input.map do |i|
      i.chars.map { |j| { char: j, h: j.tr('SE', 'az').ord, seen: false } }
    end
    find_next_steps(grid, [[x, y]], 'E', 1)
  end

  def calculate_part2
    y = input.find_index { |i| i.include? 'E' }
    x = input[y].index('E')
    grid = input.map do |i|
      i.chars.map { |j| { char: j, h: j.tr('SE', 'az').ord, seen: false } }
    end
    find_next_steps(grid, [[x, y]], 'a', -1)
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 31
    assert_equal(test_case, Main.new(File.open('./input/day12-example.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part2
    test_case = 29
    assert_equal(test_case, Main.new(File.open('./input/day12-example.txt').readlines(chomp: true)).calculate_part2)
  end

  def test_calculate_part3
    test_case = 504
    assert_equal(test_case, Main.new(File.open('./input/day12-input.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part4
    test_case = 500
    assert_equal(test_case, Main.new(File.open('./input/day12-input.txt').readlines(chomp: true)).calculate_part2)
  end
end

puts "Day12 Part1 Example: #{Main.new(File.open('./input/day12-example.txt').readlines(chomp: true)).calculate_part1}"
puts "Day12 Part2 Example: #{Main.new(File.open('./input/day12-example.txt').readlines(chomp: true)).calculate_part2}"
puts "Day12 Part1 Input: #{Main.new(File.open('./input/day12-input.txt').readlines(chomp: true)).calculate_part1}"
puts "Day12 Part2 Input: #{Main.new(File.open('./input/day12-input.txt').readlines(chomp: true)).calculate_part2}"
