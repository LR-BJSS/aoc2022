class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    input = input.map(&:chomp)
    cycle = 0
    addx = 1
    @sig_str_sum = 0
    @row = ''
    input.each do |ins|
      (1..ins.split.size).each do |i|
        @row += sprite_vis?(cycle % 40, addx) ? '#' : '.'
        cycle += 1
        @row += "\n" if div_forty?(cycle)
        @sig_str_sum += addx * cycle if div_forty?(cycle + 20)
        addx += ins.split.last.to_i if i == 2
      end
    end
  end

  def div_forty?(num)
    (num % 40).zero?
  end

  def sprite_vis?(row_i, addx)
    (row_i - addx).abs <=1
  end

  def calculate_part1
    @sig_str_sum
  end

  def calculate_part2
    @row
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    assert_equal(13140, Main.new(File.open('day10-example.txt').readlines).calculate_part1)
  end

  def test_calculate_part2
    assert_equal("##..##..##..##..##..##..##..##..##..##..
###...###...###...###...###...###...###.
####....####....####....####....####....
#####.....#####.....#####.....#####.....
######......######......######......####
#######.......#######.......#######.....
", Main.new(File.open('day10-example.txt').readlines).calculate_part2)
  end

end

puts "Day10 Part1 Example: #{Main.new(File.open('day10-example.txt').readlines).calculate_part1}"
puts "Day10 Part2 Example: \n#{Main.new(File.open('day10-example.txt').readlines).calculate_part2}"
puts "Day10 Part1 Input: #{Main.new(File.open('day10-input.txt').readlines).calculate_part1}"
puts "Day10 Part2 Input: \n#{Main.new(File.open('day10-input.txt').readlines).calculate_part2}"
