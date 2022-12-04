class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculatePt1
    total = 0
    input.split("\n") do |item|
      total += 1
      end
    return total
  end

  def calculatePt2
    total = 0
    input.split("\n") do |item|
      total += 1
    end
    return total
  end
  end

puts "Day 5 Pt 1 Example: #{Main.new(File.open('day5-example.txt').read).calculatePt1}"
puts "Day 5 Pt 2 Example: #{Main.new(File.open('day5-example.txt').read).calculatePt2}"
puts "Day 5 Pt 1 Input: #{Main.new(File.open('day5-input.txt').read).calculatePt1}"
puts "Day 5 Pt 2 Input: #{Main.new(File.open('day5-input.txt').read).calculatePt2}"

