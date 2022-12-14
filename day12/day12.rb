Node = Struct.new(:x, :y, :distance, :letter)
class HillClimbing
  def initialize(filename)
    @unvisited = []
    @possible_starts = []
    @graph = IO.readlines(filename).map.with_index do |line, row|
      line.chomp.chars.map.with_index do |char, col|
        if char == 'E'
          node = Node.new(col, row, 0, char)
        else
          node = Node.new(col, row, 100000000000, char)
          @original_start = node if char == 'S'
        end
        @unvisited << node
        @possible_starts << node if char == 'a'
        node
      end
    end
    @maxy = @graph.length - 1
    @maxx = @graph.first.length - 1
    fix_sort
  end

  def fix_sort
    @unvisited.sort_by!{|node| -1*node.distance }
  end

  def shortest_path
    loop do
      break if @unvisited.empty?
      u = @unvisited.pop
      moves(u).each do |move|
        alt = u.distance + 1
        if alt < move.distance
          move.distance = alt
        end
      end
      fix_sort
    end
    puts "Original Start distance:"
    puts @original_start.distance

    puts "Shortest distance to a"
    puts @possible_starts.map(&:distance).sort.first
  end

  def moves(node)
    x, y = node.x, node.y
    moves = []
    moves << @graph[y][x-1] if x > 0 && height_ok?(x, y, x-1, y)
    moves << @graph[y-1][x] if y > 0 && height_ok?(x, y, x, y-1)
    moves << @graph[y][x+1] if x < @maxx && height_ok?(x, y, x+1, y)
    moves << @graph[y+1][x] if y < @maxy && height_ok?(x, y, x, y+1)
    moves
  end

  def height_ok?(tox, toy, fromx, fromy)
    from = @graph[fromy][fromx].letter
    from = 'a' if from == 'S'
    to = @graph[toy][tox].letter
    to = 'z' if to == 'E'
    to.ord - from.ord <= 1
  end
end

HillClimbing.new('input-test.txt').shortest_path
HillClimbing.new('input.txt').shortest_path