def find_max(filename)
  IO.read(filename).split("\n\n").map do |chunk|
    chunk.split("\n").map(&:to_i).sum
  end.max
end

def top_three(filename)
  IO.read(filename).split("\n\n").map do |chunk|
    chunk.split("\n").map(&:to_i).sum
  end.sort.reverse[0..2].sum
end

puts 'sample'
puts find_max('input-test.txt')

puts 'first star'
puts find_max('input.txt')

puts 'sample'
puts top_three('input-test.txt')

puts 'second star'
puts top_three('input.txt')