class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculatePt1
    i = 3
    @input.chars.each_cons(4) do |q|
      i += 1
      break if q.uniq.count == q.count
    end
    return i
  end

  def calculatePt2
    j = 13
    @input.chars.each_cons(14) do |q|
      j += 1
      break if q.uniq.count == q.count
    end
    return j
  end
end

puts "Day6 Pt1 Example: #{Main.new(File.open('day6-example.txt').read).calculatePt1}"
puts "Day6 Pt2 Example: #{Main.new(File.open('day6-example.txt').read).calculatePt2}"
puts "Day6 Pt1 Input: #{Main.new(File.open('day6-input.txt').read).calculatePt1}"
puts "Day6 Pt2 Input: #{Main.new(File.open('day6-input.txt').read).calculatePt2}"
