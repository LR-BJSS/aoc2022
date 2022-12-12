class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']
  @infinity = 1000

  def initialize(input)
    @start_x = 0
    @start_y = 0
    @end_x = 0
    @end_y = 0
    @terrain = []
    @points = []

    input.split("\n") do |line|
      @terrain <<
        line.chars.map do |x|
          if %w[S E].include?(x)
            if x == 'S'
              0
            else
              27
            end
          else
            x.ord - 96
          end
        end
    end
    @terrain.each_with_index do |x, idx|
      x.each_with_index do |y, idy|
        if y == 27
          @end_x = idx
          @end_y = idy
        end
        @points << [idx, idy] if y == 1
        if y == 0
          @start_x = idx
          @start_y = idy
        end
      end
    end
    @visited = {}
    @paths = []
  end

  def step(x, y, map, steps, visited)
    return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]

    visited["#{x}:#{y}"] = steps
    current = map[x][y]
    return visited if current == 27

    up = (y - 1 >= 0 ? map[x][y - 1] : 30)
    down = (y + 1 <= map.first.size - 1 ? map[x][y + 1] : 30)
    left = (x - 1 >= 0 ? map[x - 1][y] : 30)
    right = (x + 1 <= map.size - 1 ? map[x + 1][y] : 30)

    visited = step(x, y - 1, map, steps + 1, visited) if up - current < 2 || (current == 25 && up == 27)
    visited = step(x, y + 1, map, steps + 1, visited) if down - current < 2 || (current == 25 && down == 27)
    visited = step(x - 1, y, map, steps + 1, visited) if left - current < 2 || (current == 25 && left == 27)
    visited = step(x + 1, y, map, steps + 1, visited) if right - current < 2 || (current == 25 && right == 27)
    visited
  end


  def calculate_part1
    step(@start_x, @start_y, @terrain, 0, @visited)
    @visited["#{@end_x}:#{@end_y}"]
  end

  def calculate_part2
    @points.each do |point|
      step(point[0], point[1], @terrain, 0, @visited)
      @paths << @visited["#{@end_x}:#{@end_y}"]
    end
    @paths.compact.min
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 31
    assert_equal(test_case, Main.new(File.open('./input/day12-example.txt').read).calculate_part1)
  end

  def test_calculate_part2
    test_case = 29
    assert_equal(test_case, Main.new(File.open('./input/day12-example.txt').read).calculate_part2)
  end

  def test_calculate_part3
    test_case = 504
    assert_equal(test_case, Main.new(File.open('./input/day12-input.txt').read).calculate_part1)
  end

  def test_calculate_part4
    test_case = 500
    assert_equal(test_case, Main.new(File.open('./input/day12-input.txt').read).calculate_part2)
  end
end

puts "Day12 Part1 Example: #{Main.new(File.open('./input/day12-example.txt').read).calculate_part1}"
puts "Day12 Part2 Example: #{Main.new(File.open('./input/day12-example.txt').read).calculate_part2}"
puts "Day12 Part1 Input: #{Main.new(File.open('./input/day12-input.txt').read).calculate_part1}"
puts "Day12 Part2 Input: #{Main.new(File.open('./input/day12-input.txt').read).calculate_part2}"
