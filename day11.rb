class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    parse(input)
  end

  def parse(input)
    @monkeys = input.strip.split("\n\n").map do |monkey_business|
      lines = monkey_business.split("\n")
      {
        id: lines[0].sub('Monkey ', '').sub(':', '').to_i,
        items: lines[1].sub('  Starting items: ', '').split(', ').map(&:to_i),
        operation: lines[2].sub('  Operation: new = old ', '').then do |op|
          next [:pow, 2] if op == '* old'
          (cmd, val) = op.split(' ')
          [cmd.to_sym, val.to_i]
        end,
        test_divisor: lines[3].sub('  Test: divisible by ', '').strip.to_i,
        if_true: lines[4].sub('    If true: throw to monkey ', '').to_i,
        if_false: lines[5].sub('    If false: throw to monkey ', '').to_i,
        inspections: 0
      }
    end

    def calculate_part1
      20.times do
        @monkeys.each do |monkey|
          monkey[:inspections] += monkey[:items].length
          monkey[:items].each do |initial_level|
            level = initial_level.send(*monkey[:operation]) / 3
            throw_to = (level % monkey[:test_divisor]) == 0 ? monkey[:if_true] : monkey[:if_false]
            @monkeys[throw_to][:items].push(level)
          end
          monkey[:items] = []
        end
      end
      @monkeys.map { |m| m[:inspections] }.sort.reverse.take(2).inject(&:*)
    end

    def calculate_part2
      common_divisor = @monkeys.map { |m| m[:test_divisor] }.inject(&:*)
      10000.times do
        @monkeys.each do |monkey|
          monkey[:inspections] += monkey[:items].length
          monkey[:items].each do |initial_level|
            level = initial_level.send(*monkey[:operation]) % common_divisor
            throw_to = (level % monkey[:test_divisor]) == 0 ? monkey[:if_true] : monkey[:if_false]
            @monkeys[throw_to][:items].push(level)
          end
          monkey[:items] = []
        end
      end
      @monkeys.map { |m| m[:inspections] }.sort.reverse.take(2).inject(&:*)
    end
  end

  class Test_Day_11 < Minitest::Test
    def test_calculate_part1_example
      test_case = 10605
      assert_equal(test_case, Main.new(File.open('./input/day11-example.txt').read).calculate_part1)
    end

    def test_calculate_part2_example
      test_case = 2713310158
      assert_equal(test_case, Main.new(File.open('./input/day11-example.txt').read).calculate_part2)
    end

    # input cases added once correct answers are verified by submission to aoc
    def test_calculate_part_input
      test_case = 99840
      assert_equal(test_case, Main.new(File.open('./input/day11-input.txt').read).calculate_part1)
    end

    def test_calculate_part2_input
      test_case = 20683044837
      assert_equal(test_case, Main.new(File.open('./input/day11-input.txt').read).calculate_part2)
    end
  end
end

puts "Day11 Part1 Example: #{Main.new(File.open('./input/day11-example.txt').read).calculate_part1}"
puts "Day11 Part2 Example: #{Main.new(File.open('./input/day11-example.txt').read).calculate_part2}"
puts "Day11 Part1 Input: #{Main.new(File.open('./input/day11-input.txt').read).calculate_part1}"
puts "Day11 Part2 Input: #{Main.new(File.open('./input/day11-input.txt').read).calculate_part2}"
