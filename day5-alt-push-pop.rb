class Main
  attr_reader :input

  def initialize(input)
    @stacks1 = [[], [], [], [], [], [], [], [], []]
    @stacks2 = [[], [], [], [], [], [], [], [], []]
    input.split("\n") do |line|
      if line.lstrip.start_with? "["
        for i in (1..33).step(4) do
          @stacks1[(i-1)/4].prepend(line[i]) unless line[i] == " "
          @stacks2[(i-1)/4].prepend(line[i]) unless line[i] == " "
        end
      elsif line.start_with? "move"
        ins = line.scan(/\d+/).map(&:to_i)
        ins[0].times do
          @stacks1[ins[2]-1].push(@stacks1[ins[1]-1].pop)
        end
        @stacks2[ins[2]-1].push(*@stacks2[ins[1]-1].pop(ins[0]))
      end
    end
  end

  def calculatePt1
    @stacks1.each { |stack| print stack[-1] };return
  end

  def calculatePt2
    @stacks2.each { |stack| print stack[-1] };return
  end
end

puts " = Day5 Pt1 Example #{Main.new(File.open('./input/day5-example.txt').read).calculatePt1}"
puts " = Day5 Pt2 Example #{Main.new(File.open('./input/day5-example.txt').read).calculatePt2}"
puts " = Day5 Pt1 Input #{Main.new(File.open('./input/day5-input.txt').read).calculatePt1}"
puts " = Day5 Pt2 Input #{Main.new(File.open('./input/day5-input.txt').read).calculatePt2}"