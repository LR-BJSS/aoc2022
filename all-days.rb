f = (1..12).to_a
f.each do |i|
  result = eval(File.read("day#{i}.rb"))
end

f = (16..25).to_a
f.each do |i|
  result = eval(File.read("day#{i}.rb"))
end