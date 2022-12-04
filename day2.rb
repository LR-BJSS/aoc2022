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
@total1 = 0
@total2 = 0
File.foreach("day2-input.txt") do |strategy|
    @total1 += Scores1.fetch(strategy[0,3])
    @total2 += Scores2.fetch(strategy[0,3])
end
puts "Total Part 1: #{@total1}"
puts "Total Part 2: #{@total2}"