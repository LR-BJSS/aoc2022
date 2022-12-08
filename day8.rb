class Main
  attr_reader :input

  def initialize(input)
    @input = File.readlines(input, chomp: true).map { |i| i.chars.map { |j| { height: j.to_i, visible: false, scores: [] } } }
    [@input, @input.transpose].each { |i| i.each { |j| [j, j.reverse].each { |k| process k } } }
  end

  def process(row)
    row.reduce([-1]) do |memo, cell|
      cell[:visible] = true if cell[:height] > memo.max
      cell[:scores] << ((memo.index { |i| i >= cell[:height] } || (memo.size - 2)) + 1)
      [cell[:height]] + memo
    end
  end

  def calculate_part1
    @input.flatten.select { |i| i[:visible].eql? true }.count
  end

  def calculate_part2
    @input.flatten.map { |i| i[:scores].reduce(:*) }.max
  end
end

puts "Day8 Part1 Example: #{Main.new('day8-example.txt').calculate_part1}"
puts "Day8 Part2 Example: #{Main.new('day8-example.txt').calculate_part2}"
puts "Day8 Part1 Input: #{Main.new('day8-input.txt').calculate_part1}"
puts "Day8 Part2 Input: #{Main.new('day8-input.txt').calculate_part2}"
