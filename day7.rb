class Main
  attr_reader :input
  def initialize(input)
    @input = input
  end

  def calculatePart1
    1
  end

  def calculatePart2
    2
  end
end

puts "Day7 Pt1 Example: #{Main.new(File.open('day7-example.txt').read).calculatePart1}"
puts "Day7 Pt2 Example: #{Main.new(File.open('day7-example.txt').read).calculatePart2}"
puts "Day7 Pt1 Input: #{Main.new(File.open('day7-input.txt').read).calculatePart1}"
puts "Day7 Pt2 Input: #{Main.new(File.open('day7-input.txt').read).calculatePart2}"
