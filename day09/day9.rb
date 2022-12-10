require 'set'

class RopeBridge
  def initialize(filename, tailsize = 1)
    starting_coord = 1000
    @tailsize = tailsize
    @snakex = Array.new(tailsize + 1){ starting_coord }
    @snakey = Array.new(tailsize + 1){ starting_coord }
    @tail_visited = Set.new
    @tail_visited << [@snakex.last, @snakey.last]
    @filename = filename
  end

  def run_all
    IO.readlines(@filename).each do |line|
      dir, count = line.split(' ')
      run_move(dir, count.to_i)
    end
    @tail_visited.length
  end

  def run_move(dir, count)
    count.times do
      case dir
      when 'L' then @snakex[0] -= 1
      when 'R' then @snakex[0] += 1
      when 'U' then @snakey[0] -= 1
      when 'D' then @snakey[0] += 1
      end

      1.upto(@tailsize) do |idx|
        touching = (@snakex[idx-1] - @snakex[idx]).abs <= 1 && (@snakey[idx-1] - @snakey[idx]).abs <= 1
        tol = (!touching && @snakex[idx-1] != @snakex[idx] && @snakey[idx-1] != @snakey[idx]) ? 0 : 1

        @snakex[idx] -= 1 if @snakex[idx] - @snakex[idx-1] > tol
        @snakex[idx] += 1 if @snakex[idx-1] - @snakex[idx] > tol
        @snakey[idx] -= 1 if @snakey[idx] - @snakey[idx-1] > tol
        @snakey[idx] += 1 if @snakey[idx-1] - @snakey[idx] > tol
      end

      # puts "moved #{dir}. Head - #{@headx},#{@heady}, Tail - #{@tailx}, #{@taily}"
      @tail_visited << [@snakex.last, @snakey.last]
    end
  end
end

puts RopeBridge.new('input-test.txt').run_all
puts RopeBridge.new('input.txt').run_all

puts RopeBridge.new('input-test.txt', 9).run_all
puts RopeBridge.new('input-test2.txt', 9).run_all
puts RopeBridge.new('input.txt', 9).run_all