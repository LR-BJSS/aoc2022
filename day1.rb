class Main
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def calculatePt1
    input.split("\n\n").map do |elf| # splits input by elf by looking for blank lines
      elf.split("\n").sum(&:to_i)    # sums the calories for each elf
    end.max # returns the elf with the most calories
  end

  def calculatePt2
    input.split("\n\n").map do |elf|
      elf.split("\n").sum(&:to_i)
    end.sort.last(3).sum  # returns the sum of the top 3 by sorting by calories
  end
end

puts "Day 1 Pt 1 Example: #{Main.new(File.open('day1-example.txt').read).calculatePt1}"
puts "Day 1 Pt 2 Example: #{Main.new(File.open('day1-example.txt').read).calculatePt2}"
puts "Day 1 Pt 1 Input: #{Main.new(File.open('day1-input.txt').read).calculatePt1}"
puts "Day 1 Pt 2 Input: #{Main.new(File.open('day1-input.txt').read).calculatePt2}"
