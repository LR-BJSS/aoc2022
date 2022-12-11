class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    parse(input)
  end

  def parse(input)
    # builds a stripped down hash for each monkey
    @monkeys = input.strip.split("\n\n").map do |monkey_map|
      business = monkey_map.split("\n")
      {
        items: business[1].scan(/\d+/).map(&:to_i), # extracts all the numbers to an array of integers
        operation: business[2].then do |op|
          next [:pow, 2] if op.scan(/old [*] old/).first # handle the specific "squared" case
          [business[2].scan(/[+*]/).first.to_sym, business[2].scan(/\d+$/).map(&:to_i).first] # handle +n and *n cases
        end,
        test: business[3].scan(/\d+$/).first.to_i, # number at the end of the line
        if_true: business[4].scan(/\d+$/).first.to_i, # number at the end of the line
        if_false: business[5].scan(/\d+$/).first.to_i, # number at the end of the line
        inspections: 0
      }
    end
  end

  def monkey_business(relief_factor)
    # both these approaches work, but product of divisors may be higher if source data isn't all primes
    # common_divisor = @monkeys.map { |m| m[:test] }.inject(&:*) # product of divisors
    common_divisor = @monkeys.map { |m| m[:test] }.reduce(1, :lcm) # lowest common mulitplier
    @monkeys.each do |monkey|
      monkey[:inspections] += monkey[:items].length
      monkey[:items].each do |initial_level|
        worry_level = (initial_level.send(*monkey[:operation]) / relief_factor) % common_divisor
        throw_to = (worry_level % monkey[:test]) == 0 ? monkey[:if_true] : monkey[:if_false]
        @monkeys[throw_to][:items].push(worry_level)
      end
      monkey[:items] = []
    end
  end

  def calculate_part1(relief_factor)
    20.times do
      monkey_business(relief_factor)
    end
    @monkeys.map { |m| m[:inspections] }.sort.reverse.take(2).inject(&:*)
  end

  def calculate_part2(relief_factor)
    10000.times do
      monkey_business(relief_factor)
    end
    @monkeys.map { |m| m[:inspections] }.sort.reverse.take(2).inject(&:*)
  end
end

class Test_Day_11 < Minitest::Test
  def test_calculate_part1_example
    test_case = 10605
    assert_equal(test_case, Main.new(File.open('./input/day11-example.txt').read).calculate_part1(RELIEF_PART_ONE))
  end

  def test_calculate_part2_example
    test_case = 2713310158
    assert_equal(test_case, Main.new(File.open('./input/day11-example.txt').read).calculate_part2(RELIEF_PART_TWO))
  end

  # input cases are added to aid refactoring once correct answers are verified by submission to aoc
  def test_calculate_part_input
    test_case = 99840
    assert_equal(test_case, Main.new(File.open('./input/day11-input.txt').read).calculate_part1(RELIEF_PART_ONE))
  end

  def test_calculate_part2_input
    test_case = 20683044837
    assert_equal(test_case, Main.new(File.open('./input/day11-input.txt').read).calculate_part2(RELIEF_PART_TWO))
  end
end

RELIEF_PART_ONE = 3 # Part 1 specified a relief factor of 3.
RELIEF_PART_TWO = 1 # Part 2 specified no replief factor, so 1.
puts "Day11 Part1 Example: #{Main.new(File.open('./input/day11-example.txt').read).calculate_part1(RELIEF_PART_ONE)}"
puts "Day11 Part2 Example: #{Main.new(File.open('./input/day11-example.txt').read).calculate_part2(RELIEF_PART_TWO)}"
puts "Day11 Part1 Input: #{Main.new(File.open('./input/day11-input.txt').read).calculate_part1(RELIEF_PART_ONE)}"
puts "Day11 Part2 Input: #{Main.new(File.open('./input/day11-input.txt').read).calculate_part2(RELIEF_PART_TWO)}"
