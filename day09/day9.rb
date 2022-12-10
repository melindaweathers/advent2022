require 'set'

class RopeBridge
  def initialize(filename)
    @headx = @heady = @tailx = @taily = 1000
    @tail_visited = Set.new
    @tail_visited << [@tailx, @taily]
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
      when 'L' then @headx -= 1
      when 'R' then @headx += 1
      when 'U' then @heady -= 1
      when 'D' then @heady += 1
      end

      touching = (@headx - @tailx).abs <= 1 && (@heady - @taily).abs <= 1
      tol = (!touching && @headx != @tailx && @heady != @taily) ? 0 : 1

      @tailx -= 1 if @tailx - @headx > tol
      @tailx += 1 if @headx - @tailx > tol
      @taily -= 1 if @taily - @heady > tol
      @taily += 1 if @heady - @taily > tol

      # puts "moved #{dir}. Head - #{@headx},#{@heady}, Tail - #{@tailx}, #{@taily}"
      @tail_visited << [@tailx, @taily]
    end
  end
end

puts RopeBridge.new('input-test.txt').run_all
puts RopeBridge.new('input.txt').run_all