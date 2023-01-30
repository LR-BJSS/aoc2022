class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input.map(&:chomp)
    $sd = { '=' => -2, '-' => -1, '0' => 0, '1' => 1, '2' => 2, nil => 0 }
    $ds = { -2 => '=', -1 => '-', 0 => '0', 1 => '1', 2 => '2' }
  end

  def add_snafu(s1, s2)
    sum = ''
    i = 0
    carry = 0
    s1 = s1.reverse
    s2 = s2.reverse
    while i < s1.size || i < s2.size || carry != 0
      value = carry + $sd.fetch(s1[i]) + $sd.fetch(s2[i])
      carry = 0
      if value < -2
        value += 5
        carry = -1
      end
      if value > 2
        value -= 5
        carry = 1
      end
      sum << $ds.fetch(value)
      i += 1
    end
    sum.reverse
  end

  def calculate_part1
    sum = ''
    input.each do |snafu|
      sum = add_snafu(sum, snafu)
    end
    sum
  end
end

puts "Day25 Part1 Example: #{Main.new(File.foreach('./input/day25-example.txt')).calculate_part1}"
puts "Day25 Part1 Input: #{Main.new(File.foreach('./input/day25-input.txt')).calculate_part1}"

class Test_Day_25 < Minitest::Test
  def test_calculate_part1
    test_case = "2=-1=0"
    assert_equal(test_case, Main.new(File.foreach('./input/day25-example.txt')).calculate_part1)
  end

  def test_calculate_part2
    test_case = "2-1-110-=01-1-0-0==2"
    assert_equal(test_case, Main.new(File.foreach('./input/day25-input.txt')).calculate_part1)
  end
end