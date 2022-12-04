class Main
  attr_reader :input

  SCORES = Hash[[('a'..'z').to_a, ('A'..'Z').to_a].flatten.zip((1..52).to_a)].freeze
  puts "Score Hash: #{SCORES}"

  def initialize(input)
    @input = input
  end

  def calculate
    input.split("\n").each_slice(3).to_a.map do |group_of_elves|
      group_of_elves[0].chars.map do |item|
        if group_of_elves[1].include?(item)
          SCORES[item] if group_of_elves[2].include?(item)
        end
      end.compact.uniq
    end.flatten.sum
  end
end
puts "Day 3 Pt 2 Example: #{Main.new(File.open('day3-example.txt').read).calculate}"
puts "Day 3 Pt 2 Actual: #{Main.new(File.open('day3-input.txt').read).calculate}"
