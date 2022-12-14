class Main
  attr_reader :input

  def initialize(input)
    build_file_system(input)
  end
  
  def build_file_system(input)
    @directory_sizes = Hash.new(0)
    File.open(input).readlines(chomp: true).map(&:split).each_with_object([]) do |line, stack|
      case line
      in ['$', 'cd', '..']
        stack.pop
      in ['$', 'cd', folder]
        stack.push [stack.last, folder].compact.join(' ')
      in [size, filename] if size.match?(/^\d+$/) # filename is not needed for anything
        stack.each { |i| @directory_sizes[i] += size.to_i }
      else # dir - do nothing
      end
    end
    # puts @directory_sizes.to_s
  end
  
  def calculate_part1(directory_constraint)
    @directory_sizes.values.reject { |i| i > directory_constraint }.sum
  end
  
  def calculate_part2 (free_space_required, disk_size)
    @directory_sizes.values.reject { |i| i < @directory_sizes['/'] - (disk_size - free_space_required) }.min
  end
end

puts "Directory Size Constraint = #{directory_constraint = 100000}"
puts "Free Space Required = #{free_space_required = 30000000}"
puts "Total Disk Space = #{total_disk_space = 70000000}"
puts "Example Day7 Part1 Answer: #{Main.new('./input/day7-example.txt').calculate_part1(directory_constraint)}"
puts "Example Day7 Part2 Answer: #{Main.new('./input/day7-example.txt').calculate_part2(free_space_required, total_disk_space)}"
puts "Input Day7 Part1 Answer: #{Main.new('./input/day7-input.txt').calculate_part1(directory_constraint)}"
puts "Input Day7 Part2 Answer: #{Main.new('./input/day7-input.txt').calculate_part2(free_space_required, total_disk_space)}"
