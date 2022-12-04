class Main
  attr_reader :input
  require 'active_support'
  require 'active_support/core_ext'

  def initialize(input)
    @input = input
  end

  def calculatePt1
    pairs = []
    input.split("\n") do |line|
      pairs << line.split(',').map{_1.split('-').map(&:to_i)}.map{Range.new(*_1)}
    end
    return pairs.count { |a, b| a.cover?(b) || b.cover?(a) }
  end

  def calculatePt2
    pairs = []
    input.split("\n") do |line|
      pairs << line.split(',').map{_1.split('-').map(&:to_i)}.map{Range.new(*_1)}
    end
    return pairs.count { |a, b| a.overlaps?(b) }
  end
end

puts "Day4 Pt1 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt1}"
puts "Day4 Pt2 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt2}"
puts "Day4 Pt1 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt1}"
puts "Day4 Pt2 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt2}"
