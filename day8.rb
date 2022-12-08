require "minitest/autorun"
require "minitest/reporters"
Minitest::Reporters.use! unless ENV['RM_INFO']

class Main
  attr_reader :input

  def initialize(input)
    @grid = []
    input.readlines.each do |line|
      break if line == "\n"
      @grid << line.chomp.split('').map(&:to_i)
    end
    @grid_t = @grid.transpose
  end

  def calculate_part1
    ans = @grid.length * 4 - 4
    (1..@grid.length - 2).each do |i|
      (1..@grid.length - 2).each do |j|
        left = @grid[i][0..j - 1].all? { |t| t < @grid[i][j] }
        right = @grid[i][j + 1..-1].all? { |t| t < @grid[i][j] }
        up = @grid_t[j][0..i - 1].all? { |t| t < @grid[i][j] }
        down = @grid_t[j][i + 1..-1].all? { |t| t < @grid[i][j] }
        ans += 1 if left || right || up || down
      end
    end
    ans
  end

  def calculate_part2
    ans = 1
    (1..@grid.length - 2).each do |i|
      (1..@grid.length - 2).each do |j|
        left = @grid[i][0..j - 1].reverse.find_index { |t| t >= @grid[i][j] }
        left = left ? left + 1 : @grid[i][0..j - 1].length
        right = @grid[i][j + 1..-1].find_index { |t| t >= @grid[i][j] }
        right = right ? right + 1 : @grid[i][j + 1..-1].length
        up = @grid_t[j][0..i - 1].reverse.find_index { |t| t >= @grid[i][j] }
        up = up ? up + 1 : @grid_t[j][0..i - 1].length
        down = @grid_t[j][i + 1..-1].find_index { |t| t >= @grid[i][j] }
        down = down ? down + 1 : @grid_t[j][i + 1..-1].length
        tmp = left * right * up * down
        ans = tmp if tmp > ans
      end
    end
    ans
  end
end

class Test_AOC22_8 < Minitest::Test
  def test_solve_part1
    assert_equal(21, Main.new(File.open('day8-example.txt')).calculate_part1)
  end

  def test_solve_part2
    assert_equal(8, Main.new(File.open('day8-example.txt')).calculate_part2)
  end
end

puts "Day8 Part1 Example: #{Main.new(File.open('day8-example.txt')).calculate_part1}"
puts "Day8 Part2 Example: #{Main.new(File.open('day8-example.txt')).calculate_part2}"
puts "Day8 Part1 Input: #{Main.new(File.open('day8-input.txt')).calculate_part1}"
puts "Day8 Part2 Input: #{Main.new(File.open('day8-input.txt')).calculate_part2}"
