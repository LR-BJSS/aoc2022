class Main
  attr_reader :input

  def initialize(input)
    @folder_sizes = Hash.new(0)
    File.open(input).readlines(chomp: true).map(&:split).each_with_object([]) do |line, stack|
      case line
      in ['$', 'cd', '..']
        stack.pop
      in ['$', 'cd', folder]
        stack.push [stack.last, folder].compact.join(' ')
      in [size, file] if size.match?(/^\d+$/)
        stack.each { |i| @folder_sizes[i] += size.to_i }
      else # do nothing
      end
    end
  end
  
  def calculate_part1(directory_constraint)
    @folder_sizes.values.reject { |i| i > directory_constraint }.sum
  end

  def calculate_part2 (free_space_required, disk_size)
    @folder_sizes.values.reject { |i| i < @folder_sizes['/'] - (disk_size - free_space_required) }.min
  end
end

puts "Day7 Pt1 Example: #{Main.new('day7-example.txt').calculate_part1(100000)}"
puts "Day7 Pt2 Example: #{Main.new('day7-example.txt').calculate_part2(30000000, 70000000)}"
puts "Day7 Pt1 Input: #{Main.new('day7-input.txt').calculate_part1(100000)}"
puts "Day7 Pt2 Input: #{Main.new('day7-input.txt').calculate_part2(30000000, 70000000)}"
