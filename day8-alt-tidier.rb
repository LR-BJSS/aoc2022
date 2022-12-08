def strip_newlines(strs)
  strs.map { |str| str.delete_suffix("\n") }
end

def get_input_str_arr(filename)
  true_input = strip_newlines(File.readlines(filename)) if File.exist?(filename)
  puts "input not read" if true_input.empty?
  true_input
end

def str_groups_separated_by_blank_lines(original_filename)
  groups = []
  curr_group = []

  get_input_str_arr(original_filename).each do |str|
    if str == ""
      groups << curr_group
      curr_group = []
      next
    end

    curr_group << str
  end

  groups << curr_group
  groups
end

def get_input_str(original_filename)
  get_input_str_arr(original_filename)[0]
end

def get_single_line_input_int_arr(original_filename, separator: ",")
  get_input_str(original_filename).split(separator).map(&:to_i)
end

def get_multi_line_input_int_arr(original_filename)
  get_input_str_arr(original_filename).map(&:to_i)
end

def get_multi_line_multi_value_input_int_arr(original_filename, separator: ",")
  get_input_str_arr(original_filename).map { |str_arr| str_arr.split(separator).map(&:to_i) }
end
def parse(filepath)
  get_input_str_arr(filepath)
end

def solve_pt1(heights)
  heights.map.with_index do |row, ri|
    row.chars.map.with_index do |c, ci|
      # take care of first and last row
      if ri == 0 || ri == heights.length - 1
        "v"
        # take care of first and last height along vertical sides
      elsif ci == 0 || ci == row.length - 1
        "v"
        # look left / right
      elsif c.to_i > row[0..ci - 1].chars.map(&:to_i).max ||
        c.to_i > row[ci + 1..].chars.map(&:to_i).max
        "v"
        # look up / down
      elsif c.to_i > heights[0..ri - 1].map { |h| h[ci].to_i }.max ||
        c.to_i > heights[ri + 1..].map { |h| h[ci].to_i }.max
        "v"
      end
    end
  end.reduce(0) do |acc, row|
    acc += row.count("v")
    acc
  end
end

def solve_pt2(heights)
  heights.map.with_index do |row, ri|
    row.chars.map.with_index do |c, ci|
      lt, rt, up, down = 0, 0, 0, 0
      if ri == 0 || ri == heights.length - 1
        0
      elsif ci == 0 || ci == row.length - 1
        0
      else
        (ci - 1).downto(0) do |lookleft|
          lt += 1
          break if row[lookleft].to_i >= c.to_i
        end
        (ci + 1).upto(row.length - 1) do |lookright|
          rt += 1
          break if row[lookright].to_i >= c.to_i
        end
        (ri - 1).downto(0) do |lookup|
          up += 1
          break if heights[lookup][ci].to_i >= c.to_i
        end
        (ri + 1).upto(heights.length - 1) do |lookdown|
          down += 1
          break if heights[lookdown][ci].to_i >= c.to_i
        end
        lt * rt * up * down
      end
    end
  end.map { |row| row.max }.max
end
p solve_pt1(parse("day8-example.txt"))
p solve_pt2(parse("day8-example.txt"))
p solve_pt1(parse("day8-input.txt"))
p solve_pt2(parse("day8-input.txt"))
