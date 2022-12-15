class Reservoir
  def initialize(filename)
    @graph = Hash.new('.')
    IO.readlines(filename).each do |line|
      path = line.chomp.split(' -> ').map{|coord| coord.split(',').map(&:to_i)}
      last_point = path.first
      path[1..-1].each do |point|
        if last_point[0] == point[0]
          [last_point[1],point[1]].min.upto([last_point[1],point[1]].max) { |y| @graph[[point[0], y]] = '#' }
        else
          [last_point[0],point[0]].min.upto([last_point[0],point[0]].max) { |x| @graph[[x, point[1]]] = '#' }
        end
        last_point = point
      end
    end
  end

  def drop_all_sand
    sand_units = 0
    loop do
      break unless drop_one_sand([500,0])
      sand_units += 1
    end
    sand_units
  end

  def drop_one_sand(coord, iterations = 0)
    return false if iterations > 4000
    x, y = coord
    if @graph[[x,y+1]] == '.' # down
      drop_one_sand([x,y+1], iterations + 1)
    elsif @graph[[x-1,y+1]] == '.' # down-left
      drop_one_sand([x-1,y+1], iterations + 1)
    elsif @graph[[x+1,y+1]] == '.' # down-right
      drop_one_sand([x+1,y+1], iterations + 1)
    else
      @graph[coord] = 'o'
      true
    end
  end
end

puts Reservoir.new('input-test.txt').drop_all_sand
puts Reservoir.new('input.txt').drop_all_sand