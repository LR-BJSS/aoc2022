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

puts "DayX Pt1 Example: #{Main.new(File.open('dayX-example.txt').read).calculatePart1}"
puts "DayX Pt2 Example: #{Main.new(File.open('dayX-example.txt').read).calculatePart2}"
puts "DayX Pt1 Input: #{Main.new(File.open('dayX-input.txt').read).calculatePart1}"
puts "DayX Pt2 Input: #{Main.new(File.open('dayX-input.txt').read).calculatePart2}"
