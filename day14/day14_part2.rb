class Reservoir
  def initialize(filename)
    @graph = Hash.new('.')
    max_y = 0
    IO.readlines(filename).each do |line|
      path = line.chomp.split(' -> ').map{|coord| coord.split(',').map(&:to_i)}
      last_point = path.first
      max_y = [last_point[1], max_y].max
      path[1..-1].each do |point|
        if last_point[0] == point[0]
          [last_point[1],point[1]].min.upto([last_point[1],point[1]].max) { |y| @graph[[point[0], y]] = '#' }
        else
          [last_point[0],point[0]].min.upto([last_point[0],point[0]].max) { |x| @graph[[x, point[1]]] = '#' }
        end
        last_point = point
        max_y = [last_point[1], max_y].max
      end
    end
    @floor_y = max_y + 2
  end

  def drop_all_sand
    sand_units = 0
    loop do
      break unless drop_one_sand([500,0])
      sand_units += 1
    end
    sand_units
  end

  def drop_one_sand(coord)
    return false if @graph[[500,0]] == 'o'
    x, y = coord
    if y + 1 == @floor_y
      @graph[coord] = 'o'
      true
    elsif @graph[[x,y+1]] == '.' # down
      drop_one_sand([x,y+1])
    elsif @graph[[x-1,y+1]] == '.' # down-left
      drop_one_sand([x-1,y+1])
    elsif @graph[[x+1,y+1]] == '.' # down-right
      drop_one_sand([x+1,y+1])
    else
      @graph[coord] = 'o'
      true
    end
  end
end

puts Reservoir.new('input-test.txt').drop_all_sand
puts Reservoir.new('input.txt').drop_all_sand