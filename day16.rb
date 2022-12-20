class Main
  attr_reader :input
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  def initialize(input)
    @input = input
    @valves = input.lines.map {|l| l.scan(/\d+/).map(&:to_i) + l.scan(/[A-Z]{2}/) }
                 .map {|a| {a[1] => {flow: a[0], conn: a[2..]}} }.reduce({}, :merge)

    $dist = {}
    def get_dist(valves, pos, to)
      k = {from: pos, to: to}
      return $dist[k] if $dist.key?(k)
      to_a = [to]
      to_na = []
      dist = 0
      until to_a.include?(pos)
        to_a.each do |to|
          to_na += valves.filter {|k,v| v[:conn].include?(to) }.keys
        end
        to_a = to_na.uniq
        to_na = []
        dist += 1
      end
      $dist[k] = dist
      return dist
    end

  end

  def calculate_part1
    solve(@valves, ["AA","AA"], 30, 0)
  end

  def calculate_part2
    solve(@valves, ["AA","AA"], 26, 26)
  end
end


def get_moves(valves, pos, rel, minute_rem, openn = [])
  moves = {}
  valves.each do |k,v|
    next if openn.include?(k) || v[:flow] == 0
    dist = get_dist(valves, pos, k)
    rem = minute_rem-dist-1
    next if rem < 0
    release = v[:flow]*rem
    val = {rel: release+rel, open: openn + [k], pos: k}
    if moves.key?(rem)
      moves[rem] = [val, moves[rem]].max_by {|v| v[:rel]}
    else
      moves[rem] = val
    end
  end
  moves
end

def solve(valves, pos, minute_rem1, minute_rem2)
  moves = {[minute_rem1,minute_rem2]=>{rel: 0, open: [], pos: pos}}
  best = 0
  until moves.length == 0
    max_move = moves.max_by {|k,v| k}
    pos_moves = get_moves(valves, max_move[1][:pos][0], max_move[1][:rel], max_move[0][0], max_move[1][:open])
    pos_moves = pos_moves.map do |k,v|
      if k > max_move[0][1]
        [[k, max_move[0][1]], {rel: v[:rel], open: v[:open], pos: [v[:pos], max_move[1][:pos][1]]}]
      else
        [[max_move[0][1], k], {rel: v[:rel], open: v[:open], pos: [max_move[1][:pos][1], v[:pos]]}]
      end
    end.to_h
    if max_move[0].uniq.length == 1 && max_move[1][:pos].uniq.length > 1
      pos_moves2 = get_moves(valves, max_move[1][:pos][1], max_move[1][:rel], max_move[0][0], max_move[1][:open])
      pos_moves2 = pos_moves2.map do |k,v|
        if k > max_move[0][1]
          [[k, max_move[0][1]], {rel: v[:rel], open: v[:open], pos: [v[:pos], max_move[1][:pos][0]]}]
        else
          [[max_move[0][1], k], {rel: v[:rel], open: v[:open], pos: [max_move[1][:pos][0], v[:pos]]}]
        end
      end.to_h
      pos_moves.merge!(pos_moves2) {|k, v1, v2| [v1,v2].max_by {|v| v[:rel]} }
    end
    best = [best, max_move[1][:rel]].max
    moves.delete(max_move[0])
    moves.merge!(pos_moves) {|k, v1, v2| [v1,v2].max_by {|v| v[:rel]} }
  end
  return best
end

class Test_Day_10 < Minitest::Test
  def test_calculate_part1
    test_case = 1651
    assert_equal(test_case, Main.new(File.open('./input/day16-example.txt').read).calculate_part1)
  end

  def test_calculate_part2
    test_case = 1707
    assert_equal(test_case, Main.new(File.open('./input/day16-example.txt').read).calculate_part2)
  end

  def test_calculate_part3
    test_case = 1807
    assert_equal(test_case, Main.new(File.open('./input/day16-input.txt').read).calculate_part1)
  end

  def test_calculate_part4
    test_case = 2264
    assert_equal(test_case, Main.new(File.open('./input/day16-input.txt').read).calculate_part2)
  end
end

puts "DayX Part1 Example: #{Main.new(File.open('./input/day16-example.txt').read).calculate_part1}"
puts "DayX Part2 Example: #{Main.new(File.open('./input/day16-example.txt').read).calculate_part2}"
puts "DayX Part1 Input: #{Main.new(File.open('./input/day16-input.txt').read).calculate_part1}"
puts "DayX Part2 Input: #{Main.new(File.open('./input/day16-input.txt').read).calculate_part2}"
