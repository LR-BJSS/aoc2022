class Main
  attr_reader :input, :blueprints
  require "set"
  require "minitest/autorun"
  require "minitest/reporters"
  Minitest::Reporters.use! unless ENV['RM_INFO']

  Blueprint = Struct.new(:id, :oreBotOre, :clayBotOre,
                         :obsBotOre, :obsBotClay,
                         :geodeBotOre, :geodeBotObs)

  BotState = Struct.new(:minutes,
                        :oreBotCnt, :clayBotCnt, :obsBotCnt, :geodeBotCnt,
                        :ore, :clay, :obs, :geode)

  def initialize(input)
    @input = input
    @blueprints = input.map { |line| Blueprint.new(*line.scan(/(\d+)/).flatten.map(&:to_i)) }
  end

  def getBestGeodes(bp, minutes)
    best = 0
    queue = [BotState.new(minutes, 1, 0, 0, 0, 0, 0, 0, 0)]
    visited = Set.new
    while (queue.size > 0)
      curr = queue.shift
      if (!visited.include?(curr))
        visited << curr
        if (curr.minutes == 0)
          if (best < curr.geode)
            best = curr.geode # New best Blueprint found
          end
        else
          n = BotState.new(
            curr.minutes - 1,
            curr.oreBotCnt,
            curr.clayBotCnt,
            curr.obsBotCnt,
            curr.geodeBotCnt,
            curr.ore + curr.oreBotCnt,
            curr.clay + curr.clayBotCnt,
            curr.obs + curr.obsBotCnt,
            curr.geode + curr.geodeBotCnt
          )
          # always build geode bot if you can
          canBuildGeodeBot = (curr.ore >= bp.geodeBotOre && curr.obs >= bp.geodeBotObs)
          # don't build obs bot if you can build geode bot
          canBuildObsBot = !canBuildGeodeBot &&
            # don't need more obs than 1 geodeBot per min
            (curr.obsBotCnt < bp.geodeBotObs) &&
            (curr.ore >= bp.obsBotOre && curr.clay >= bp.obsBotClay)
          # don't build clay bot if you can build geode bot
          canBuildClayBot = !canBuildGeodeBot && !canBuildObsBot &&
            # don't need more clay than 1 obsBot per min
            (curr.clayBotCnt < bp.obsBotClay) &&
            (curr.ore >= bp.clayBotOre)
          canBuildOreBot = !canBuildGeodeBot && !canBuildObsBot &&
            # don't need more ore than the max any bot could need per min
            (curr.oreBotCnt < [bp.geodeBotOre, bp.obsBotOre, bp.clayBotOre].max) &&
            (curr.ore >= bp.oreBotOre)
          # don't want to hoard if we can build a geode bot
          canBuildNothing = !canBuildGeodeBot &&
            # don't idle if we have already hoarded more clay and ore than we need
            (curr.ore < 2 * [bp.geodeBotOre, bp.obsBotOre, bp.clayBotOre].max) &&
            (curr.clay < 3 * bp.obsBotClay)
          # push build nothing state only
          queue << n if (canBuildNothing)
          # push build geode bot state
          queue << BotState.new(
            n.minutes,
            n.oreBotCnt,
            n.clayBotCnt,
            n.obsBotCnt,
            n.geodeBotCnt + 1,
            n.ore - bp.geodeBotOre,
            n.clay,
            n.obs - bp.geodeBotObs,
            n.geode
          ) if (canBuildGeodeBot)

          # push build obs bot state
          queue << BotState.new(
            n.minutes,
            n.oreBotCnt,
            n.clayBotCnt,
            n.obsBotCnt + 1,
            n.geodeBotCnt,
            n.ore - bp.obsBotOre,
            n.clay - bp.obsBotClay,
            n.obs,
            n.geode
          ) if (canBuildObsBot)

          # push build clay bot state
          queue << BotState.new(
            n.minutes,
            n.oreBotCnt,
            n.clayBotCnt + 1,
            n.obsBotCnt,
            n.geodeBotCnt,
            n.ore - bp.clayBotOre,
            n.clay,
            n.obs,
            n.geode
          ) if (canBuildClayBot)

          # push build ore bot state
          queue << BotState.new(
            n.minutes,
            n.oreBotCnt + 1,
            n.clayBotCnt,
            n.obsBotCnt,
            n.geodeBotCnt,
            n.ore - bp.oreBotOre,
            n.clay,
            n.obs,
            n.geode
          ) if (canBuildOreBot)
        end
      end
    end
    return best
  end

  def calculate_part1
    blueprints.map { |bp| getBestGeodes(bp, 24) * bp.id }.sum
  end

  def calculate_part2
    blueprints[0..2].map { |bp| getBestGeodes(bp, 32) }.inject(1, :*)
  end
end

class Test_Day_19 < Minitest::Test
  def test_calculate_part1
    test_case = 33
    assert_equal(test_case, Main.new(File.open('./input/day19-example.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part2
    test_case = 3348
    assert_equal(test_case, Main.new(File.open('./input/day19-example.txt').readlines(chomp: true)).calculate_part2)
  end

  def test_calculate_part3
    test_case = 2193
    assert_equal(test_case, Main.new(File.open('./input/day19-input.txt').readlines(chomp: true)).calculate_part1)
  end

  def test_calculate_part4
    test_case = 6800
    assert_equal(test_case, Main.new(File.open('./input/day19-input.txt').readlines(chomp: true)).calculate_part2)
  end
end

puts "Day19 Part1 Example: #{Main.new(File.open('./input/day19-example.txt').readlines(chomp: true)).calculate_part1}"
puts "Day19 Part2 Example: #{Main.new(File.open('./input/day19-example.txt').readlines(chomp: true)).calculate_part2}"
puts "Day19 Part1 Input: #{Main.new(File.open('./input/day19-input.txt').readlines(chomp: true)).calculate_part1}"
puts "Day19 Part2 Input: #{Main.new(File.open('./input/day19-input.txt').readlines(chomp: true)).calculate_part2}"