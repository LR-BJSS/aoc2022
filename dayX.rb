class Main
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def calculate_part1
    1
  end

  def calculate_part2
    2
  end
end

puts "DayX Part1 Example: #{Main.new(File.open('dayX-example.txt').read).calculate_part1}"
puts "DayX Part2 Example: #{Main.new(File.open('dayX-example.txt').read).calculate_part2}"
puts "DayX Part1 Input: #{Main.new(File.open('dayX-input.txt').read).calculate_part1}"
puts "DayX Part2 Input: #{Main.new(File.open('dayX-input.txt').read).calculate_part2}"
