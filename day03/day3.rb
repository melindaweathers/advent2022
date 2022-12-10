def priority(chr)
  chr.ord < 97 ? chr.ord - 38 : chr.ord - 96
end

def common_letter(str)
  chrs = str.chars
  intersection = chrs[0..(chrs.length - 1) / 2] & chrs[(chrs.length)/2 .. - 1]
  priority intersection.first
end

def priority_sum(filename)
  IO.readlines(filename).map{|line| common_letter(line)}.sum
end

def item_group_sum(filename)
  IO.readlines(filename).each_slice(3).map do |a, b, c|
    common_letter((a.chars & b.chars & c.chars).first)
  end.sum
end

puts priority_sum('input-test.txt')
puts priority_sum('input.txt')

puts item_group_sum('input-test.txt')
puts item_group_sum('input.txt')