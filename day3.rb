class Main
  attr_reader :input
  # build a clever hash of 52 characters and their scores
  SCORE = Hash[[('a'..'z').to_a, ('A'..'Z').to_a].flatten.zip((1..52).to_a)].freeze

  def initialize(input)
    @input = input
  end

  def calculatePt1
    input.split("\n").map do |rucksack|
      first_compartment = rucksack.chars.first(rucksack.size/2).join('')
      second_compartment = rucksack.chars.last(rucksack.size/2).join('')
      first_compartment.chars.map do |item|
        SCORE[item] if second_compartment.include?(item)
      end.compact.uniq
    end.flatten.sum
  end

  def calculatePt2
    input.split("\n").each_slice(3).to_a.map do |group_of_elves|
      group_of_elves[0].chars.map do |item|
        if group_of_elves[1].include?(item)
          SCORE[item] if group_of_elves[2].include?(item)
        end
      end.compact.uniq
    end.flatten.sum
  end
end

puts "Day3 Pt1 Example: #{Main.new(File.open('day3-example.txt').read).calculatePt1}"
puts "Day3 Pt2 Example: #{Main.new(File.open('day3-example.txt').read).calculatePt2}"
puts "Day3 Pt1 Input: #{Main.new(File.open('day3-input.txt').read).calculatePt1}"
puts "Day3 Pt2 Input: #{Main.new(File.open('day3-input.txt').read).calculatePt2}"
