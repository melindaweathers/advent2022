def count_contains(filename)
  IO.readlines(filename).map do |line|
    elf1from, elf1to, elf2from, elf2to = line.split(/[-,]/).map(&:to_i)
    contained = (elf1from.between?(elf2from, elf2to) && elf1to.between?(elf2from, elf2to)) || 
      (elf2from.between?(elf1from, elf1to) && elf2to.between?(elf1from, elf1to))
    contained ? 1 : 0
  end.sum
end

puts count_contains('input-test.txt')
puts count_contains('input.txt')

def count_overlaps(filename)
  IO.readlines(filename).map do |line|
    elf1from, elf1to, elf2from, elf2to = line.split(/[-,]/).map(&:to_i)
    contained = elf1from.between?(elf2from, elf2to) || elf1to.between?(elf2from, elf2to) || 
      elf2from.between?(elf1from, elf1to) || elf2to.between?(elf1from, elf1to)
    contained ? 1 : 0
  end.sum
end

puts count_overlaps('input-test.txt')
puts count_overlaps('input.txt')