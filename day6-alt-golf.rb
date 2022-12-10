[4,14].each_with_object(File.open('./input/day6-example.txt').read.chars){|i,s|s.each_cons(i).with_index(i){break p _2 if _1.uniq.size==i}}
[4,14].each_with_object(File.open('./input/day6-input.txt').read.chars){|i,s|s.each_cons(i).with_index(i){break p _2 if _1.uniq.size==i}}
