class Main
  attr_reader :input, :vars
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  Exp = Struct.new(:l, :op, :r)

  def initialize(input)
    @input = input
    @vars = {}
    input.map do |line|
      var, exp = line.split(': ')
      exp = exp.split
      vars[var] = if exp.size == 1
                    exp.first.to_i
                  else
                    Exp.new(exp[0], exp[1].to_sym, exp[2])
                  end
    end
  end

  def evaluate(vars, var)
    v = vars[var]
    if v.is_a?(Numeric)
      v
    else
      l = evaluate(vars, v.l)
      r = evaluate(vars, v.r)
      l.method(v.op).call(r)
    end
  end

  def symbolic_evaluate(vars, var)
    return var if var == 'humn'

    v = vars[var]
    if v.is_a?(Numeric)
      v
    else
      l = symbolic_evaluate(vars, v.l)
      r = symbolic_evaluate(vars, v.r)
      if l.is_a?(Numeric) && r.is_a?(Numeric)
        l.method(v.op).call(r)
      else
        Exp.new(l, v.op, r)
      end
    end
  end

  def calculate_part1
    evaluate(vars, 'root')
  end

  def calculate_part2
    exp = vars['root']
    l = symbolic_evaluate(vars, exp.l)
    r = symbolic_evaluate(vars, exp.r)
    l, r = r, l unless r.is_a?(Numeric)
    until l == 'humn'
      if l.l.is_a?(Numeric)
        r = case l.op
            when :+
              # 3 + (...) = r => (...) = r - 3
              r - l.l
            when :-
              # 3 - (...) = r => -(...) = r + 3 => (...) = -(r + 3) = 3 - r
              l.l - r
            when :*
              # 3 * (...) = r => (...) = r / 3
              r / l.l
            when :/
              # 3 / (...) = r => 3 = (...) * r => (...) = 3 / r
              l.l / r
            end
        l = l.r
      elsif l.r.is_a?(Numeric)
        r = case l.op
            when :+
              # (...) + 3 = r => (...) = r - 3
              r - l.r
            when :-
              # (...) - 3 = r => (...) = r + 3
              r + l.r
            when :*
              # (...) * 3 = r => (...) = r / 3
              r / l.r
            when :/
              # (...) / 3 = r => (...) = r * 3
              r * l.r
            end
        l = l.l
      end
    end
    r
  end
end

class Test_Day_21 < Minitest::Test
  def test_calculate_part1
    test_case = 152
    assert_equal(test_case, Main.new(File.open('./input/day21-example.txt').readlines).calculate_part1)
  end

  def test_calculate_part2
    test_case = 301
    assert_equal(test_case, Main.new(File.open('./input/day21-example.txt').readlines).calculate_part2)
  end

  def test_calculate_part3
    test_case = 331319379445180
    assert_equal(test_case, Main.new(File.open('./input/day21-input.txt').readlines).calculate_part1)
  end

  def test_calculate_part4
    test_case = 3715799488132
    assert_equal(test_case, Main.new(File.open('./input/day21-input.txt').readlines).calculate_part2)
  end
end

puts "Day21 Part1 Example: #{Main.new(File.open('./input/day21-example.txt').readlines).calculate_part1}"
puts "Day21 Part2 Example: #{Main.new(File.open('./input/day21-example.txt').readlines).calculate_part2}"
puts "Day21 Part1 Input: #{Main.new(File.open('./input/day21-input.txt').readlines).calculate_part1}"
puts "Day21 Part2 Input: #{Main.new(File.open('./input/day21-input.txt').readlines).calculate_part2}"
