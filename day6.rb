class Main
  attr_reader :input

  def initialize(input)
    @input = input
  end

  def calculate(marker)
    start_of_message = marker - 1               # we can start at 'marker' - 1 as it isn't possible any earlier
    @input.chars.each_cons(marker) do |message| # iterate for each consecutive message that is 'marker' long
      start_of_message += 1
      break if message.uniq.count == message.count # checks that everything in the message is unique
    end
    return start_of_message
  end
end

puts "Day6 Pt1 Example: #{Main.new(File.open('day6-example.txt').read).calculate(4)}"
puts "Day6 Pt2 Example: #{Main.new(File.open('day6-example.txt').read).calculate(14)}"
puts "Day6 Pt1 Input: #{Main.new(File.open('day6-input.txt').read).calculate(4)}"
puts "Day6 Pt2 Input: #{Main.new(File.open('day6-input.txt').read).calculate(14)}"
