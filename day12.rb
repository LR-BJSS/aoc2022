class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @infinity = 100
    @start_x, @start_y, @end_x, @end_y = 0, 0, 0, 0
    @terrain, @low_points, @paths, @visited = [], [], [], {}

    input.split("\n") do |line|
      @terrain << line.chars.map do |x|
        case x
        when 'S' # the start point
          0
        when 'E' # the end point
          27
        else
          x.ord - 96 # ascii a to z returns 1 to 26
        end
      end
    end
    # initialise our start and end x & y indexes
    @terrain.each_with_index do |x, idx|
      x.each_with_index do |y, idy|
        if y == 27
          @end_x = idx
          @end_y = idy
        end
        if y == 0
          @start_x = idx
          @start_y = idy
        end
        @low_points << [idx, idy] if y == 1 # creates an array of the lowest points (a) for part 2
      end
    end
  end

  def dijkstra(x, y, map, steps, visited)
    return visited if !visited["#{x}:#{y}"].nil? && steps >= visited["#{x}:#{y}"]
    visited["#{x}:#{y}"] = steps
    current = map[x][y]
    return visited if current == 27
    up = (y - 1 >= 0 ? map[x][y - 1] : 30)
    down = (y + 1 <= map.first.size - 1 ? map[x][y + 1] : 30)
    left = (x - 1 >= 0 ? map[x - 1][y] : 30)
    right = (x + 1 <= map.size - 1 ? map[x + 1][y] : 30)
    # Check that next location can be visited + 1 height, or any lower hight + special case of END from y (25)
    visited = dijkstra(x, y - 1, map, steps + 1, visited) if up - current < 2 || (current == 25 && up == 27)
    visited = dijkstra(x, y + 1, map, steps + 1, visited) if down - current < 2 || (current == 25 && down == 27)
    visited = dijkstra(x - 1, y, map, steps + 1, visited) if left - current < 2 || (current == 25 && left == 27)
    visited = dijkstra(x + 1, y, map, steps + 1, visited) if right - current < 2 || (current == 25 && right == 27)
    visited
  end

  def calculate_part1
    dijkstra(@start_x, @start_y, @terrain, 0, @visited)
    @visited["#{@end_x}:#{@end_y}"]
  end

  def calculate_part2
    @low_points.each do |point|
      dijkstra(point[0], point[1], @terrain, 0, @visited)
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
