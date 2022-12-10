class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  RELEVANT_CYCLES = [20, 60, 100, 140, 180, 220].freeze
  WIDTH = 40

  def initialize(input)
    @input ||= input.map { |line| line.chomp.split }
  end

  def execute(action)
    x, cycle = 1, 0
    input.each_with_object([]) do |line, output|
      instruction, argument = line
      case instruction
      when "noop"
        output << action.call(x, cycle)
        cycle += 1
      when "addx"
        2.times do
          output << action.call(x, cycle)
          cycle += 1
        end
        x += argument.to_i
      end
    end
  end

  def render_output(output)
    output.each_slice(WIDTH).map { |row| row.join }.join("\n")
  end

  def calculate_part1
    execute(
      -> (x, cycle) { RELEVANT_CYCLES.include?(cycle + 1) ? (x * (cycle + 1)) : 0 }
    ).sum
  end

  def calculate_part2
    render_output(
      execute(
        -> (x, pos) { [x - 1, x, x + 1].include?(pos % WIDTH) ? "█" : "░" }
      )
    )
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 13140
    assert_equal(test_case, Main.new(File.open('./input/day10-example.txt').readlines).calculate_part1)
  end

  def test_calculate_part2
    test_case = "██░░██░░██░░██░░██░░██░░██░░██░░██░░██░░\n"\
                "███░░░███░░░███░░░███░░░███░░░███░░░███░\n"\
                "████░░░░████░░░░████░░░░████░░░░████░░░░\n"\
                "█████░░░░░█████░░░░░█████░░░░░█████░░░░░\n"\
                "██████░░░░░░██████░░░░░░██████░░░░░░████\n"\
                "███████░░░░░░░███████░░░░░░░███████░░░░░"
    assert_equal(test_case, Main.new(File.open('./input/day10-example.txt').readlines).calculate_part2)
  end
end

puts "Day10 Part1 Example: #{Main.new(File.open('./input/day10-example.txt').readlines).calculate_part1}"
puts "Day10 Part2 Example: \n#{Main.new(File.open('./input/day10-example.txt').readlines).calculate_part2}"
puts "Day10 Part1 Input: #{Main.new(File.open('./input/day10-input.txt').readlines).calculate_part1}"
puts "Day10 Part2 Input: \n#{Main.new(File.open('./input/day10-input.txt').readlines).calculate_part2}"
