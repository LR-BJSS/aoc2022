def monkey_math(monkeys)
  Hash.new { |h, k|
    v = monkeys.fetch(k)
    h[k] = v.is_a?(Integer) ? v : h[v[0]].send(v[1], h[v[2]])
  }
end

monkeys = File.open('./input/day21-input.txt').read.each_line(chomp: true).to_h { |line| line.split(': ', 2) }.transform_values { |v|
  if v.match?(/\A\d+\z/)
    Integer(v)
  elsif v.match?(/\A\w+ [-+*\/] \w+\z/)
    v.split.map(&:freeze).freeze
  else
    raise "bad monkey #{v}"
  end
}.freeze

orig = monkey_math(monkeys)
puts orig['root']

rootl, _, rootr = monkeys.fetch('root')
human1 = monkey_math(monkeys.merge('humn' => 1))
leq = human1[rootl] == orig[rootl]
req = human1[rootr] == orig[rootr]

change_monkey, change_val, check_val = case [leq, req]
                                       when [true, false]; [rootr, human1[rootr], orig[rootl]]
                                       when [false, true]; [rootl, human1[rootl], orig[rootr]]
                                       when [false, false]; raise 'both changed'
                                       when [true, true]; raise 'neither changed'
                                       else raise 'impossible'
                                       end

orig_cmp = change_val <=> check_val
cmp_changed = ->v { (monkey_math(monkeys.merge('humn' => v))[change_monkey] <=> check_val) != orig_cmp }

search_factor = 128
upper = Enumerator.produce(1) { |v| v * search_factor }.find(&cmp_changed)
puts ((upper / search_factor)..upper).bsearch(&cmp_changed)