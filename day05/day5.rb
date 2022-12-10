class SupplyStacks
  def initialize(filename, num_stacks)
    @stacks = Array.new(num_stacks){ [] }
    @num_stacks = num_stacks
    @moves = []
    had_blank = false
    IO.readlines(filename).each do |line|
      if line.chomp == ""
        had_blank = true
      elsif had_blank
        @moves << line[5..-1].split(/ from | to /).map(&:to_i)
      else
        0.upto(num_stacks - 1) do |stack|
          char = line[ 4*stack + 1]
          @stacks[stack].unshift(char) if char =~ /[A-Z]/
        end
      end
    end
  end

  def rearrange
    @moves.each do |move|
      move[0].times { @stacks[move[2] - 1].push(@stacks[move[1] - 1].pop)}
    end
    @stacks.map{|stack| stack.last}.join('')
  end

  def rearrange_9001
    @moves.each do |move|
      tmpstack = []
      move[0].times { tmpstack.push(@stacks[move[1] - 1].pop)}
      @stacks[move[2] - 1] += tmpstack.reverse
    end
    @stacks.map{|stack| stack.last}.join('')
  end

end

puts SupplyStacks.new('input-test.txt', 3).rearrange
puts SupplyStacks.new('input.txt', 9).rearrange

puts SupplyStacks.new('input-test.txt', 3).rearrange_9001
puts SupplyStacks.new('input.txt', 9).rearrange_9001