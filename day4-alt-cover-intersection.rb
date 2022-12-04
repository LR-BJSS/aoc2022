class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculatePt1
    pairs = input.split("\n").map { |pair| pair.split(",").map { |range_s| range_s.split("-").map(&:to_i) }.map { |b, e| b..e } }
    return pairs.count { |a, b| a.cover?(b) or b.cover?(a) }
  end

  def calculatePt2
    pairs = input.split("\n").map { |pair| pair.split(",").map { |range_s| range_s.split("-").map(&:to_i) }.map { |b, e| b..e } }
    pairs.count { |a, b| !a.to_a.intersection(b.to_a).empty? }
  end
end

puts "Day4 Pt1 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt1}"
puts "Day4 Pt2 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt2}"
puts "Day4 Pt1 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt1}"
puts "Day4 Pt2 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt2}"

