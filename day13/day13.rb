def in_order?(a, b)
  if a.empty? && b.empty?
    nil
  elsif a.empty? && !b.empty?
    true
  elsif !a.empty? && b.empty?
    false
  elsif a.first.respond_to?(:even?) && b.first.respond_to?(:even?)
    if a.first == b.first
      in_order?(a[1..-1], b[1..-1])
    else
      a.first < b.first
    end
  else
    arr_in_order = in_order?(Array(a.first), Array(b.first))
    arr_in_order.nil? ? in_order?(a[1..-1], b[1..-1]) : arr_in_order
  end
end

def count_in_order(filename)
  IO.read(filename).split("\n\n").map.with_index do |pair, index|
    first, second = pair.split("\n").map{|arr| send(:eval, arr)}
    in_order?(first, second) ? (index + 1) : 0
  end.sum
end

def put_in_order(filename)
  @lists = [[[2]], [[6]]]
  IO.readlines(filename).each do |line|
    next if line.chomp.empty?
    list = send(:eval, line.chomp)
    0.upto(@lists.length) do |idx|
      if idx == @lists.length
        @lists << list
      elsif in_order?(list, @lists[idx])
        @lists.insert(idx, list)
        break
      end
    end
  end
  [@lists.index([[2]]) + 1, @lists.index([[6]]) + 1].inject(&:*)
end

puts count_in_order('input-test.txt')
puts count_in_order('input.txt')

puts put_in_order('input-test.txt')
puts put_in_order('input.txt')

