class Main
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def calculatePt1
    input.split("\n\n").map do |elf| # splits input by elf by looking for double newline
      elf.split("\n").sum(&:to_i)    # sums the calories for each elf by splitting each line and converting to integer
    end.max # returns the elf with the most calories (max)
  end

  def calculatePt2
    input.split("\n\n").map do |elf|
      elf.split("\n").sum(&:to_i)
    end.sort.last(3).sum  # returns the sum of the top 3 by sorting by calories (last part of hash)
  end
end

puts "Day1 Pt1 Example: #{Main.new(File.open('./input/day1-example.txt').read).calculatePt1}"
puts "Day1 Pt2 Example: #{Main.new(File.open('./input/day1-example.txt').read).calculatePt2}"
puts "Day1 Pt1 Input: #{Main.new(File.open('./input/day1-input.txt').read).calculatePt1}"
puts "Day1 Pt2 Input: #{Main.new(File.open('./input/day1-input.txt').read).calculatePt2}"
