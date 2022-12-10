class Forest
  def initialize(filename)
    @grid = []
    IO.readlines(filename).each do |line|
      @grid << line.chomp.chars
    end
    @num_rows = @grid.length
    @num_cols = @grid.first.length
  end

  def visible_trees
    visible = (2 * @num_rows) + (2 * @num_cols) - 4
    1.upto(@num_rows - 2).map do |y|
      1.upto(@num_cols - 2).map do |x|
        visible?(x,y) ? 1 : 0
      end.sum
    end.sum + visible
  end

  def visible?(x, y)
    val = @grid[y][x]
    0.upto(y-1).all?{|row| @grid[row][x] < val} ||
      (y+1).upto(@num_rows - 1).all?{|row| @grid[row][x] < val} ||
      0.upto(x-1).all?{|row| @grid[y][row] < val} ||
      (x+1).upto(@num_cols - 1).all?{|row| @grid[y][row] < val}
  end

  def best_scenic
    1.upto(@num_rows - 2).map do |y|
      1.upto(@num_cols - 2).map do |x|
        scenic_score(x,y)
      end.max
    end.max
  end

  def scenic_score(x, y)
    val = @grid[y][x]
    left = right = up = down = 0
    (y-1).downto(0).each{|row| down += 1; break if @grid[row][x] >= val }
    (y+1).upto(@num_rows - 1).each{|row| up += 1; break if @grid[row][x] >= val }
    (x-1).downto(0).each{|col| left += 1; break if @grid[y][col] >= val }
    (x+1).upto(@num_cols - 1).each{|col| right += 1; break if @grid[y][col] >= val }
    left * right * up * down
  end
end

puts Forest.new('input-test.txt').visible_trees
puts Forest.new('input.txt').visible_trees

puts Forest.new('input-test.txt').best_scenic
puts Forest.new('input.txt').best_scenic