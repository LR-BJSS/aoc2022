instr_cycles = { 'addx' => 2, 'noop' => 1 }
x = [1]

File.readlines('day10-input.txt').each do |l|
  instr, value = l.strip.split
  cycles = instr_cycles[instr]
  1.upto(cycles) do |c|
    x << (c == cycles ? x.last + value.to_i : x.last)
  end
end

signals = [20, 60, 100, 140, 180, 220].map { |i| x[i - 1] * i }
p "Part 1: #{signals.sum}"

p "Part 2:"
x.each_with_index do |s, i|
  position = i % 40
  print ((s - 1..s + 1).to_a.include?(position) ? '@' : ' ')
  print "\n" if position == 39
end