class Main
  attr_reader :input

  def initialize(input)
    build_file_system(input)
  end

  def reset_globals
    $small_directories_total = 0
    $directory_totals = []
  end

  def build_file_system(input)
    @file_system = { '/' => {} }
    path = []

    input.each do |line|
      line.chomp!
      commands = line.split(' ')
      if line.include? '$'
        # commands
        _, command, arg = commands
        case command
        when 'ls' # do nothing
        when 'cd'
          if arg == '..'
            path.pop
          else
            path.push(arg)
          end
        else
          # do nothing
        end
      else
        # the result of ls
        current_dir = @file_system.dig(*path)
        arg1, arg2 = commands
        current_dir[arg2] = if arg1 == 'dir'
                              {}
                            else
                              arg1
                            end
      end
    end
    # puts @file_system.to_s
  end

  def scan_file_system(file_system, path, constraint)
    directory_size = 0
    current_dir = file_system.dig(*path)
    current_dir.each_key do |sub_dir|
      value = current_dir[sub_dir]
      directory_size += if value.is_a?(Hash)
                          scan_file_system(file_system, path.dup.push(sub_dir), constraint)
                        else
                          value.to_i
                        end
    end
    $small_directories_total += directory_size if directory_size <= constraint
    $directory_totals << directory_size
    directory_size
  end

  def calculate_part1(directory_constraint)
    reset_globals
    scan_file_system(@file_system, ['/'], directory_constraint)
    $small_directories_total
  end

  def calculate_part2 (free_space_required, disk_size)
    reset_globals
    unused_space = disk_size - scan_file_system(@file_system, ['/'], disk_size)
    to_delete = free_space_required - unused_space
    $directory_totals.select { |n| n > to_delete }.min # Total of smallest directories to delete 
  end

end

puts "Day7 Pt1 Example: #{Main.new(File.open('./input/day7-example.txt').readlines).calculate_part1(100000)}"
puts "Day7 Pt2 Example: #{Main.new(File.open('./input/day7-example.txt').readlines).calculate_part2(30000000, 70000000)}"
puts "Day7 Pt1 Input: #{Main.new(File.open('./input/day7-input.txt').readlines).calculate_part1(100000)}"
puts "Day7 Pt2 Input: #{Main.new(File.open('./input/day7-input.txt').readlines).calculate_part2(30000000, 70000000)}"
