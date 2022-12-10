class Cpu
  def initialize(filename)
    @cycle = 1
    @x = 1
    @filename = filename
    @special_cycles = []
    @pixels = Array.new(6) { Array.new(40) }
  end

  def execute
    IO.readlines(@filename).each do |line|
      op, num = line.chomp.split(' ')
      run_op(op, num.to_i)
    end
    @special_cycles.sum
  end

  def run_op(op, num)
    if op == 'noop'
      start_cycle
    elsif op == 'addx'
      start_cycle
      store_special_cycles
      start_cycle
      @x += num
    end
    store_special_cycles
  end

  def start_cycle
    pixel_pos = (@cycle - 1) % 40
    pixel = (pixel_pos - @x).abs <= 1 ? '#' : '.'
    print pixel
    puts if @cycle % 40 == 0
    @cycle += 1
  end

  def store_special_cycles
    if (@cycle - 20) % 40 == 0
      @special_cycles << (@x * @cycle)
    end
  end
end

puts Cpu.new('input-test.txt').execute
puts Cpu.new('input.txt').execute

