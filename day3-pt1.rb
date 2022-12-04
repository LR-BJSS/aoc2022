class Main
  attr_reader :input

  SCORE = Hash[[('a'..'z').to_a, ('A'..'Z').to_a].flatten.zip((1..52).to_a)].freeze
  puts "Score Hash: #{SCORE}"

  def initialize(input)
    @input = input
  end

  def calculate
    input.split("\n").map do |rucksack|
      first_compartment = rucksack.chars.first(rucksack.size/2).join('')
      last_compartment = rucksack.chars.last(rucksack.size/2).join('')
      first_compartment.chars.map do |item|
        SCORE[item] if last_compartment.include?(item)
      end.compact.uniq
    end.flatten.sum
  end
end
puts "Day 3 Pt 1 Example: #{Main.new(File.open('day3-example.txt').read).calculate}"
puts "Day 3 Pt 1 Actual: #{Main.new(File.open('day3-input.txt').read).calculate}"
