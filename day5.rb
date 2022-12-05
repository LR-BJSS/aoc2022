class Main
  attr_reader :input
  MoveCommand = Struct.new(:amount, :from, :to)
  def initialize(input)
    raw_stacks, raw_commands = input.split("\n\n")
    @stacks = parse_raw_stacks(raw_stacks)
    @commands = parse_raw_commands(raw_commands)
  end
  def parse_raw_stacks(raw_stacks)
    raw_stacks
      .split("\n")
      .map(&:chars)
      .transpose
      .map { _1.join.strip }
      .filter { _1.match?(/\d/) }
      .map { _1[0..-2].chars.reverse }
  end

  def parse_raw_commands(raw_commands)
    raw_commands
      .split("\n")
      .map { |line|
        line
          .match(/move (\d+) from (\d) to (\d)/)
          .captures
          .map(&:to_i)
          .map.with_index { |number, index| index == 0 ? number : number - 1 }
          .then { MoveCommand.new(_1, _2, _3) }
      }
  end

  def run_crane(crate_stacks, move_commands, strategy)
    stack = crate_stacks.map(&:clone)
    move_commands.each do |move|
      stack[move.from]
        .pop(move.amount)
        .send(strategy)
        .then { stack[move.to].concat _1 }
    end
    stack.map(&:last).join
  end

  def calculatePt1
    run_crane(@stacks, @commands, :reverse)
    end

  def calculatePt2
    run_crane(@stacks, @commands, :itself)
    end
end

puts "Day5 Pt1 Example: #{Main.new(File.open('day5-example.txt').read).calculatePt1}"
puts "Day5 Pt2 Example: #{Main.new(File.open('day5-example.txt').read).calculatePt2}"
puts "Day5 Pt1 Input: #{Main.new(File.open('day5-input.txt').read).calculatePt1}"
puts "Day5 Pt2 Input: #{Main.new(File.open('day5-input.txt').read).calculatePt2}"
