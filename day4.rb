class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculatePt1
    total = 0
    input.split("\n") do |line|
      first_elf, second_elf = line.split(",").map { |parts| parts.split("-").map(&:to_i) }
      if (first_elf.first <= second_elf.first && first_elf.last >= second_elf.last) || (second_elf.first <= first_elf.first && second_elf.last >= first_elf.last)
        total += 1
      end
    end
    return total
  end

  def calculatePt2
    total = 0
    input.split("\n") do |line|
      first_elf, second_elf = line.split(",").map { |parts| parts.split("-").map(&:to_i) }
      if (first_elf.first <= second_elf.last && second_elf.first <= first_elf.last) || (first_elf.first >= second_elf.last && second_elf.first >= first_elf.last)
        total += 1
      end
    end
    return total
  end
end

puts "Day4 Pt1 Example: #{Main.new(File.open('./input/day4-example.txt').read).calculatePt1}"
puts "Day4 Pt2 Example: #{Main.new(File.open('./input/day4-example.txt').read).calculatePt2}"
puts "Day4 Pt1 Input: #{Main.new(File.open('./input/day4-input.txt').read).calculatePt1}"
puts "Day4 Pt2 Input: #{Main.new(File.open('./input/day4-input.txt').read).calculatePt2}"
