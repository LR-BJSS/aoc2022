class Main
  attr_reader :input
  require 'set'
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input.to_a.map(&:chomp)
    empty_valley = input.map { |line| line.gsub(/[><v^]/, '.') }
    iwidth = @input[0].size - 2
    iheight = @input.size - 2
    phase_count = iwidth.lcm(iheight)
    $phases = phase_count.times.map { empty_valley.map(&:dup) }
    # puts "phase_count: #{phase_count}"
    @input.size.times do |y|
      @input[y].size.times do |x|
        case @input[y][x]
        when 'v' then path = ->(time) { [x, 1 + (y - 1 + time) % iheight] }
        when '^' then path = ->(time) { [x, 1 + (y - 1 - time) % iheight] }
        when '>' then path = ->(time) { [1 + (x - 1 + time) % iwidth, y] }
        when '<' then path = ->(time) { [1 + (x - 1 - time) % iwidth, y] }
        else next
        end
        $phases.each_with_index do |phase, time|
          x2, y2 = path.call(time)
          phase[y2][x2] = 'B'
        end
      end
    end
  end

  def possible_next_coords(time, coords)
    phase = $phases.fetch((time + 1) % $phases.size)
    x, y = coords
    candidates = [[x, y], [x + 1, y], [x - 1, y], [x, y + 1], [x, y - 1]]
    candidates.select do |coords|
      (phase[coords[1]] || '')[coords[0]] == '.'
    end
  end

  def manhattan_distance(coords1, coords2)
    (coords1[0] - coords2[0]).abs + (coords1[1] - coords2[1]).abs
  end

  def find_path(time, start, goal)
    queue = [[nil, time, start, [start]]]
    visited = Set.new
    iteration_count = 0
    while true
      bcs, time, coords, path = queue.shift

      visitation_state = [time, coords]
      next if visited.include?(visitation_state)
      visited << visitation_state

      if (iteration_count % 10000) == 0 && iteration_count > 0
        # puts "Analyzing time=#{time} coords=#{coords}, queue=#{queue.size}"
      end
      return time if coords == goal # success
      next_time = time + 1
      possible_next_coords(time, coords).each do |next_coords|
        best_case_score = next_time + manhattan_distance(next_coords, goal)
        entry = [best_case_score, next_time, next_coords, path + [next_coords]]
        index = queue.each_index.find { |i| queue[i][0] > entry[0] } || queue.size
        queue.insert(index, entry)
      end
      iteration_count += 1
    end
  end

  def calculate_part1
    valley_entrance = [input.first.index('.'), 0]
    valley_exit = [input.last.index('.'), input.size - 1]
    time = find_path(0, valley_entrance, valley_exit)
  end

  def calculate_part2
    valley_entrance = [input.first.index('.'), 0]
    valley_exit = [input.last.index('.'), input.size - 1]
    time = find_path(0, valley_entrance, valley_exit)
    time = find_path(time, valley_exit, valley_entrance)
    time = find_path(time, valley_entrance, valley_exit)
  end
end

class Test_Day_24 < Minitest::Test
  def test_calculate_part1
    test_case = 18
    assert_equal(test_case, Main.new(File.foreach('./input/day24-example.txt')).calculate_part1)
  end

  def test_calculate_part2
    test_case = 54
    assert_equal(test_case, Main.new(File.foreach('./input/day24-example.txt')).calculate_part2)
  end

  def test_calculate_part3
    test_case = 266
    assert_equal(test_case, Main.new(File.foreach('./input/day24-input.txt')).calculate_part1)
  end

  def test_calculate_part4
    test_case = 853
    assert_equal(test_case, Main.new(File.foreach('./input/day24-input.txt')).calculate_part2)
  end
end

puts "Day24 Part1 Example: #{Main.new(File.foreach('./input/day24-example.txt')).calculate_part1}"
puts "Day24 Part2 Example: #{Main.new(File.foreach('./input/day24-example.txt')).calculate_part2}"
puts "Day24 Part1 Input: #{Main.new(File.foreach('./input/day24-input.txt')).calculate_part1}"
puts "Day24 Part2 Input: #{Main.new(File.foreach('./input/day24-input.txt')).calculate_part2}"
