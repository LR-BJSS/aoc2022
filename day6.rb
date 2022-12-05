class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculatePt1
    return 1
  end

  def calculatePt2
    return 2
  end
end

puts "Day6 Pt1 Example: #{Main.new(File.open('day6-example.txt').read).calculatePt1}"
puts "Day6 Pt2 Example: #{Main.new(File.open('day6-example.txt').read).calculatePt2}"
puts "Day6 Pt1 Input: #{Main.new(File.open('day6-input.txt').read).calculatePt1}"
puts "Day6 Pt2 Input: #{Main.new(File.open('day6-input.txt').read).calculatePt2}"
