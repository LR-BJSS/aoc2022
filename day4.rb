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

puts "Day 4 Pt 1 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt1}"
puts "Day 4 Pt 2 Example: #{Main.new(File.open('day4-example.txt').read).calculatePt2}"
puts "Day 4 Pt 1 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt1}"
puts "Day 4 Pt 2 Input: #{Main.new(File.open('day4-input.txt').read).calculatePt2}"
