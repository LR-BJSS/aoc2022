@total = 0
@size = 0
@compartment = 0
@c1
@c2
@priority
@grandtotal = 0
Priorities = {
  'a' => (1), # 1
  'b' => (2), # 1
  'c' => (3), # 1
  'd' => (4), # 1
  'e' => (5), # 1
  'f' => (6), # 1
  'g' => (7), # 1
  'h' => (8), # 1
  'i' => (9), # 1
  'j' => (10), # 1
  'k' => (11), # 1
  'l' => (12), # 1
  'm' => (13), # 1
  'n' => (14), # 1
  'o' => (15), # 1
  'p' => (16), # 1
  'q' => (17), # 1
  'r' => (18), # 1
  's' => (19), # 1
  't' => (20), # 1
  'u' => (21), # 1
  'v' => (22), # 1
  'w' => (23), # 1
  'x' => (24), # 1
  'y' => (25), # 1
  'z' => (26), # 1
  'A' => (27), # 1
  'B' => (28), # 1
  'C' => (29), # 1
  'D' => (30), # 1
  'E' => (31), # 1
  'F' => (32), # 1
  'G' => (33), # 1
  'H' => (34), # 1
  'I' => (35), # 1
  'J' => (36), # 1
  'K' => (37), # 1
  'L' => (38), # 1
  'M' => (39), # 1
  'N' => (40), # 1
  'O' => (41), # 1
  'P' => (42), # 1
  'Q' => (43), # 1
  'R' => (44), # 1
  'S' => (45), # 1
  'T' => (46), # 1
  'U' => (47), # 1
  'V' => (48), # 1
  'W' => (49), # 1
  'X' => (50), # 1
  'Y' => (51), # 1
  'Z' => (52) # 1
}
File.foreach("day3-input.txt") do |rucksack|
  puts rucksack
  @size = rucksack.size-1
  @compartment = @size/2
  @c1 = rucksack[0,@compartment]
  @c2 = rucksack[@compartment,@size]
  @total += 1
  puts "Size: #{@size}"
  puts "Compartment #{@compartment}"
  puts "C1 #{@c1}"
  puts "C2 #{@c2}"
  @c1.each_char do |c1c|
    if @c2.include?(c1c) then
      @priority = Priorities.fetch(c1c)
      puts "Item: #{c1c}"
    end
  end
  puts "Priority: #{@priority}"
  @grandtotal += @priority.to_i
end
puts "Total Rucksacks: " + @total.to_s
puts "Total Priorities: #{@grandtotal}"