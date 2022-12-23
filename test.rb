# Part 1
map = {}
lines = File.open('./input/day22-input.txt').readlines
place = nil
lines.each_with_index do |l, y|
  l.chomp.chars.each_with_index do |c, x|
    map[[x, y]] = c if c != ' '
    place = [x, y] unless place
  end
  break if l.strip.empty?
end
# p lines.last
x_min, x_max = map.keys.map(&:first).minmax
y_min, y_max = map.keys.map(&:last).minmax

facing = [1, 0]
rotate_right = -> dx, dy { [-dy, dx] }
rotate_left = -> dx, dy { [dy, -dx] }

draw = -> {
  (y_min..y_max).each do |y|
    (x_min..x_max).each do |x|
      c = map[[x, y]]
      if c.nil?
        print ' '
      elsif [x, y] == place
        print case facing
              when [1, 0] then '>'
              when [-1, 0] then '<'
              when [0, 1] then 'v'
              when [0, -1] then '^'
              end
      else
        print c
      end
    end
    puts
  end
  puts '======================='
}

p path = lines.last.scan(/\d+|R|L/)
path.each do |v|
  if v == 'R'
    facing = rotate_right[*facing]
  elsif v == 'L'
    facing = rotate_left[*facing]
  else
    v.to_i.times do
      next_place = [place.first + facing.first, place.last + facing.last]
      char = map[next_place]
      if char.nil?
        ys_on_x = map.keys.select { |x, y| x == next_place.first }.map(&:last)
        xs_on_y = map.keys.select { |x, y| y == next_place.last }.map(&:first)
        if facing == [1, 0]
          next_place = [xs_on_y.min, next_place.last]
        elsif facing == [-1, 0]
          next_place = [xs_on_y.max, next_place.last]
        elsif facing == [0, 1]
          next_place = [next_place.first, ys_on_x.min]
        elsif facing == [0, -1]
          next_place = [next_place.first, ys_on_x.max]
        end
        char = map[next_place]
      end
      if char == '#'
        break
      end
      place = next_place
      # draw[]
      # sleep 0.1
    end
  end
  # draw[]
  # sleep 0.1
end
draw[]
p [place, facing]
facing_score = case facing
               when [1, 0] then 0
               when [-1, 0] then 2
               when [0, 1] then 1
               when [0, -1] then 3
               end
row = place[1] + 1
col = place[0] + 1
p row * 1000 + col * 4 + facing_score

# Part 2
$cube_data = {
  A: {
    origin: [1, 0],
    up: [:F, 1],
    down: [:C, 0],
    left: [:E, 2],
    right: [:B, 0],
  },
  B: {
    origin: [2, 0],
    up: [:F, 0],
    down: [:C, 1],
    left: [:A, 0],
    right: [:D, 2],
  },
  C: {
    origin: [1, 1],
    up: [:A, 0],
    down: [:D, 0],
    left: [:E, 3],
    right: [:B, 3],
  },
  D: {
    origin: [1, 2],
    up: [:C, 0],
    down: [:F, 1],
    left: [:E, 0],
    right: [:B, 2],
  },
  E: {
    origin: [0, 2],
    up: [:C, 1],
    down: [:F, 0],
    left: [:A, 2],
    right: [:D, 0],
  },
  F: {
    origin: [0, 3],
    up: [:E, 0],
    down: [:B, 0],
    left: [:A, 3],
    right: [:D, 3],
  }
}

class Cube
  def initialize(size)
    @size = size
  end
  def face_coord(point)
    $cube_data.each do |k, v|
      origin = v[:origin]
      if point[0] >= origin[0] * @size && point[0] < (origin[0] + 1) * @size &&
        point[1] >= origin[1] * @size && point[1] < (origin[1] + 1) * @size
        return [k, point[0] - origin[0] * @size, point[1] - origin[1] * @size]
      end
    end
    raise "no face for #{point}"
  end
  def resolve(from, to)
    from_face, from_x, from_y = from
    to_x, to_y = to
    instructions = nil
    go = ->(dir, dx, dy) {
      to_face, rotation = $cube_data[from_face][dir]
      tx, ty = to_x + dx, to_y + dy
      rotate_right = -> {
        tx, ty = @size - ty - 1, tx
      }
      rotation.times { rotate_right[] }
      [to_face, tx, ty, rotation]
    }
    if to_y < 0
      go[:up, 0, @size]
    elsif to_y >= @size
      go[:down, 0, -@size]
    elsif to_x < 0
      go[:left, @size, 0]
    elsif to_x >= @size
      go[:right, -@size, 0]
    else
      return [from_face, to_x, to_y, 0]
    end
  end
  def xy_coord(face_coord)
    face, x, y = face_coord
    origin = $cube_data[face][:origin]
    [origin[0] * @size + x, origin[1] * @size + y]
  end
end

$cube = Cube.new(50)

map = {}
lines = $stdin.readlines
place = nil
lines.each_with_index do |l, y|
  l.chomp.chars.each_with_index do |c, x|
    if c != ' '
      map[[x, y]] = c
      place = [x, y] unless place
    end
  end
  break if l.strip.empty?
end
# p lines.last
x_min, x_max = map.keys.map(&:first).minmax
y_min, y_max = map.keys.map(&:last).minmax

facing = [1, 0]
rotate_right = -> dx, dy { [-dy, dx] }
rotate_left = -> dx, dy { [dy, -dx] }
p board_size = y_max - y_min + 1

wrap = -> place, next_place, facing {
  face_coord = $cube.face_coord(place)
  p ['WRAP', place, next_place, facing, face_coord]

  dx, dy = next_place[0] - place[0], next_place[1] - place[1]
  next_face, nx, ny, rotations = $cube.resolve(face_coord, [face_coord[1] + dx, face_coord[2] + dy])
  next_place = $cube.xy_coord([next_face, nx, ny])
  rotations.times { facing = rotate_right[*facing] }
  [next_place, facing]
}

draw = -> {
  (y_min..y_max).each do |y|
    (x_min..x_max).each do |x|
      c = map[[x, y]]
      if c.nil?
        print ' '
      elsif [x, y] == place
        print case facing
              when [1, 0] then '>'
              when [-1, 0] then '<'
              when [0, 1] then 'v'
              when [0, -1] then '^'
              end
      else
        print c
      end
    end
    puts
  end
  puts '======================='
}

p path = lines.last.scan(/\d+|R|L/)
path.each do |v|
  if v == 'R'
    facing = rotate_right[*facing]
  elsif v == 'L'
    facing = rotate_left[*facing]
  else
    v.to_i.times do
      next_place = [place.first + facing.first, place.last + facing.last]
      next_facing = facing
      char = map[next_place]
      if char.nil?
        next_place, next_facing = wrap[place, next_place, facing]
        char = map[next_place]
      end
      if char == '#'
        break
      end
      place = next_place
      facing = next_facing
      # draw[]
      # sleep 0.1
    end
  end
  # draw[]
  # sleep 0.1
end
draw[]
p [place, facing]
facing_score = case facing
               when [1, 0] then 0
               when [-1, 0] then 2
               when [0, 1] then 1
               when [0, -1] then 3
               end
row = place[1] + 1
col = place[0] + 1
p row * 1000 + col * 4 + facing_scorepyc