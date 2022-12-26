class Main
  attr_reader :input
  require 'set'
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
    @input_set = Set.new
    input.with_index do |line, y|
      line.each_char.with_index do |c, x|
        @input_set << [x, y] if c == '#'
      end
    end
  end

  def print_set(set)
    min_x = set.min_by { _1[0] }[0]
    max_x = set.max_by { _1[0] }[0]
    min_y = set.min_by { _1[1] }[1]
    max_y = set.max_by { _1[1] }[1]
    (min_y..max_y).each do |y|
      (min_x..max_x).each do |x|
        print set.include?([x, y]) ? '#' : '.'
      end
      puts
    end
  end

  def vec_plus(a, b)
    [a.fetch(0) + b.fetch(0), a.fetch(1) + b.fetch(1)]
  end

  def do_round(set, round_number)
    all_dirs = [[1, 0], [1, 1], [0, 1], [-1, 1], [-1, 0], [-1, -1], [0, -1], [1, -1]]

    # Figure out the order that directions are proposed.
    pdirs = [[0, -1], [0, 1], [-1, 0], [1, 0]]
    (round_number % 4).times do
      pdirs << pdirs.shift
    end

    # Calculate the proposals.
    proposals = {}
    set.each do |elf|
      proposal = nil
      lonely = all_dirs.none? { |dir| set.include?(vec_plus(elf, dir)) }
      pdirs.each do |dir|
        candidate = vec_plus(elf, dir)
        perps = dir[0] == 0 ? [[-1, 0], [1, 0]] : [[0, -1], [0, 1]]
        checks = [candidate, vec_plus(candidate, perps[0]), vec_plus(candidate, perps[1])]
        if checks.none? { |c| set.include?(c) }
          proposal = candidate
          break
        end
      end if !lonely
      proposal ||= elf
      (proposals[proposal] ||= []) << elf
    end

    # Calculate the new set.
    new_set = Set.new
    proposals.each do |proposal, elves|
      if elves.size == 1
        new_set.add(proposal)
      else
        new_set.merge(elves)
      end
    end
    new_set
  end

  def count_empty_ground(set)
    min_x = set.min_by { _1[0] }[0]
    max_x = set.max_by { _1[0] }[0]
    min_y = set.min_by { _1[1] }[1]
    max_y = set.max_by { _1[1] }[1]

    (max_x - min_x + 1) * (max_y - min_y + 1) - set.size
  end
  def calculate_part1
    set = @input_set
    10.times do |round_number|
      set = do_round(set, round_number)
      raise if set.size != @input_set.size
    end
    count_empty_ground(set)
  end

  def calculate_part2
    set = @input_set
    10000000.times do |round_number|
      new_set = do_round(set, round_number)
      if new_set == set
        return (round_number + 1)
        break
      end
      set = new_set
    end
  end
end

class Test_Day_23 < Minitest::Test
  def test_calculate_part1
    test_case = 110
    assert_equal(test_case, Main.new(File.foreach('./input/day23-example.txt')).calculate_part1)
  end

  def test_calculate_part2
    test_case = 20
    assert_equal(test_case, Main.new(File.foreach('./input/day23-example.txt')).calculate_part2)
  end

  def test_calculate_part3
    test_case = 4056
    assert_equal(test_case, Main.new(File.foreach('./input/day23-input.txt')).calculate_part1)
  end

  def test_calculate_part4
    test_case = 999
    assert_equal(test_case, Main.new(File.foreach('./input/day23-input.txt')).calculate_part2)
  end
end

puts "Day23 Part1 Example: #{Main.new(File.foreach('./input/day23-example.txt')).calculate_part1}"
puts "Day23 Part2 Example: #{Main.new(File.foreach('./input/day23-example.txt')).calculate_part2}"
puts "Day23 Part1 Input: #{Main.new(File.foreach('./input/day23-input.txt')).calculate_part1}"
puts "Day23 Part2 Input: #{Main.new(File.foreach('./input/day23-input.txt')).calculate_part2}"
