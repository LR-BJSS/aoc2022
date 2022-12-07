class Main
  attr_reader :input

  def initialize(input)
    buildfilesystem(input)
  end

  def buildfilesystem(input)
    @file_system = { '/' => {} }
    path = []

    input.each do |line|
      line.chomp!
      commands = line.split(' ')
      if line.include? '$'
        # commands
        _, command, arg = commands
        case command
        when 'ls'
          # do nothing
        when 'cd'
          if arg == '..'
            path.pop
          else
            path.push(arg)
          end
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

  def scanfilesystem(file_system, path, constraint)
    directory_total = 0
    current_dir = file_system.dig(*path)
    current_dir.each_key do |sub_dir|
      value = current_dir[sub_dir]
      directory_total += if value.is_a?(Hash)
                           scanfilesystem(file_system, path.dup.push(sub_dir),constraint)
                         else
                           value.to_i
                         end
    end
    $small_total += directory_total if directory_total <= constraint
    $directory_totals << directory_total
    directory_total
  end

  def calculatePart1(directory_constraint)
    $small_total = 0
    $directory_totals = []
    scanfilesystem(@file_system, ['/'],directory_constraint)
    $small_total
  end

  def calculatePart2 (free_space_required, disk_size)
    $small_total = 0
    $directory_totals = []
    unused_space = disk_size - scanfilesystem(@file_system, ['/'],disk_size)
    to_delete = free_space_required - unused_space
    $directory_totals.select { |n| n > to_delete }.min # Smallest Directory to Delete
  end
end

puts "Day7 Pt1 Example: #{Main.new(File.open('day7-example.txt').readlines).calculatePart1(100000)}"
puts "Day7 Pt2 Example: #{Main.new(File.open('day7-example.txt').readlines).calculatePart2(30000000,70000000)}"
puts "Day7 Pt1 Input: #{Main.new(File.open('day7-input.txt').readlines).calculatePart1(100000)}"
puts "Day7 Pt2 Input: #{Main.new(File.open('day7-input.txt').readlines).calculatePart2(30000000,70000000)}"
