class Main
    attr_reader :input
    Scores1 = {
      'A X' => (1+3), # Rock Rock (Draw)
      'A Y' => (2+6), # Rock Paper (Win)
      'A Z' => (3+0), # Rock Sciscors (Lose)
      'B X' => (1+0), # Paper Rock (Lose)
      'B Y' => (2+3), # Paper Paper (Draw)
      'B Z' => (3+6), # Paper Scisors (Win)
      'C X' => (1+6), # Scisors Rock (Win)
      'C Y' => (2+0), # Scisors Paper (Lose)
      'C Z' => (3+3)  # Scisors Scisors (Draw)
    }
    Scores2 = {
      'A X' => (3+0), # Rock Lose (Scissors)
      'A Y' => (1+3), # Rock Draw (Rock)
      'A Z' => (2+6), # Rock Win (Paper)
      'B X' => (1+0), # Paper Lose (Scissors)
      'B Y' => (2+3), # Paper Draw (Paper)
      'B Z' => (3+6), # Paper Win (Rock)
      'C X' => (2+0), # Scissors Lose (Paper)
      'C Y' => (3+3), # Scissors Draw (Scissors)
      'C Z' => (1+6)  # Scoscors Win (Rock)
    }
    def initialize(input)
        @input = input
    end

    def calculatePt1
        total = 0
        input.split("\n") do |strategy|
            total += Scores1.fetch(strategy[0,3])
        end
        return total
    end

    def calculatePt2
        total = 0
        input.split("\n") do |strategy|
            total += Scores2.fetch(strategy[0,3])
        end
        return total
    end
end

puts "Day 2 Pt 1 Example: #{Main.new(File.open('day2-example.txt').read).calculatePt1}"
puts "Day 2 Pt 2 Example: #{Main.new(File.open('day2-example.txt').read).calculatePt2}"
puts "Day 2 Pt 1 Input: #{Main.new(File.open('day2-input.txt').read).calculatePt1}"
puts "Day 2 Pt 2 Input: #{Main.new(File.open('day2-input.txt').read).calculatePt2}"
