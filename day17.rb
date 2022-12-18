class Main
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  LEFT_OFFSET = 2
  BOTTOM_OFFSET = 3
  CHAMBER_WIDTH = 7
  TRUNCATE_CHAMBER = 3000
  ROCKS = [["####"], [" # ", "###", " # "], ["  #", "  #", "###"], ["#", "#", "#", "#"], ["##", "##"]]
  @shapes = Array.new
  lines = File.open('./input/day17-shapes.txt').readlines
  shape = Array.new
  lines.each do |line|
    if line == '/n'
      @shapes.push(shape)
    else
      line.chomp
      shape.push(line)
    end
  end
  puts @shapes.to_s

  def initialize(input)
    @jets = input.first.chars
    @jet_idx, @rock_idx, @shifts, @tower, @part1, @part2 = 0, 0, 0, 0, 0, 0
    @chamber = []
  end

  def solve
    seen = {}
    loop do
      if @chamber.length == TRUNCATE_CHAMBER
        break if seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % @jets.length]]
        seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % @jets.length]] = [@rock_idx, @shifts + @chamber.length]
      end
      simulation_step
      @part1 = @shifts + @chamber.length if @rock_idx == 2022
    end
    chamber_height = @shifts + @chamber.length
    rock_idx_was, chamber_height_was = seen[[@chamber, @rock_idx % ROCKS.length, @jet_idx % @jets.length]]
    # this config was seen when rock_idx was `rock_idx_was` and chamber_height was `chamber_height_was`
    # it has been seen again now with rock_idx = `@rock_idx` and chamber_height = `chamber_height`
    loops, extra = (1_000_000_000_000 - @rock_idx).divmod(@rock_idx - rock_idx_was)
    @tower = loops * (chamber_height - chamber_height_was)
    # we have to do `loops` complete loops with extra `extra` rocks, adding `omg` height
    extra.times do
      simulation_step
    end
    @part2 = @shifts + @chamber.length + @tower
  end

  def calculate_part1
    solve
    @part1
  end

  def calculate_part2
    solve
    @part2
  end

  def simulation_step
    BOTTOM_OFFSET.times { @chamber << " " * CHAMBER_WIDTH }
    rock = ROCKS[@rock_idx % ROCKS.length].reverse.map.with_index do |line, row|
      line.chars.map.with_index { |char, col| { char: char, row: @chamber.length + row, col: col + LEFT_OFFSET } }
    end
    @rock_idx += 1
    rock.length.times { @chamber << " " * CHAMBER_WIDTH }
    loop do
      jet_push(rock)
      break unless fall(rock)
    end
    rock.each do |row|
      row.each do |cell|
        @chamber[cell[:row]][cell[:col]] = cell[:char] if cell[:char] == "#"
      end
    end

    @chamber.pop while @chamber.last.strip.empty?
    while @chamber.length > TRUNCATE_CHAMBER
      @chamber.shift
      @shifts += 1
    end
  end

  def jet_push(rock)
    jet = @jets[@jet_idx % @jets.length]
    @jet_idx += 1
    dcol = jet == "<" ? -1 : 1
    rock.each do |row|
      row.each do |cell|
        next unless cell[:char] == "#"
        col = cell[:col] + dcol
        return false unless (0...CHAMBER_WIDTH).include?(col)
        return false if @chamber[cell[:row]][col] == "#"
      end
    end
    rock.each do |row|
      row.each do |cell|
        cell[:col] += dcol
      end
    end
    true
  end

  def fall(rock)
    rock.each do |row|
      row.each do |cell|
        return false if cell[:row] == 0
        return false if cell[:char] == "#" && @chamber[cell[:row] - 1][cell[:col]] == "#"
      end
    end
    rock.each do |row|
      row.each do |cell|
        cell[:row] -= 1
      end
    end
    true
  end
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 3068
    assert_equal(test_case, Main.new(File.open('./input/day17-example.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part2
    test_case = 1514285714288
    assert_equal(test_case, Main.new(File.open('./input/day17-example.txt').readlines(chomp: true)).calculate_part2)
  end

  def test_calculate_part3
    test_case = 3141
    assert_equal(test_case, Main.new(File.open('./input/day17-input.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part4
    test_case = 1561739130391
    assert_equal(test_case, Main.new(File.open('./input/day17-input.txt').readlines(chomp: true)).calculate_part2)
  end
end

puts "Day17 Part1 Example: #{Main.new(File.open('./input/day17-example.txt').readlines(chomp: true)).calculate_part1}"
puts "Day17 Part2 Example: #{Main.new(File.open('./input/day17-example.txt').readlines(chomp: true)).calculate_part2}"
puts "Day17 Part1 Input: #{Main.new(File.open('./input/day17-input.txt').readlines(chomp: true)).calculate_part1}"
puts "Day17 Part2 Input: #{Main.new(File.open('./input/day17-input.txt').readlines(chomp: true)).calculate_part2}"
