Node = Struct.new(:x, :y, :distance, :letter)
class HillClimbing
  def initialize(filename)
    @unvisited = []
    @graph = IO.readlines(filename).map.with_index do |line, row|
      line.chomp.chars.map.with_index do |char, col|
        if char == 'S'
          node = Node.new(col, row, 0, char)
          @start = node
        else
          node = Node.new(col, row, 100000000000, char)
          @end = node if char == 'E'
        end
        @unvisited << node
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
    @end.distance
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

  def height_ok?(fromx, fromy, tox, toy)
    from = @graph[fromy][fromx].letter
    from = 'a' if from == 'S'
    to = @graph[toy][tox].letter
    to = 'z' if to == 'E'
    to.ord - from.ord <= 1
  end
end

puts HillClimbing.new('input-test.txt').shortest_path
puts HillClimbing.new('input.txt').shortest_path