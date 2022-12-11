Monkey = Struct.new(:items, :operation_op, :operation_val, :test_div, :if_true, :if_false, :num)
class KeepAway
  def initialize(filename)
    @monkeys = IO.read(filename).split("\n\n").map do |chunk|
      lines = chunk.split("\n")
      items = lines[1][18..-1].split(', ').map(&:to_i)
      operation_op = lines[2][23]
      operation_val = lines[2][25..-1]
      test_div = lines[3].split(' by ')[1].to_i
      if_true = lines[4].split(' monkey ')[1].to_i
      if_false = lines[5].split(' monkey ')[1].to_i 
      Monkey.new(items, operation_op, operation_val, test_div, if_true, if_false, 0)
    end
    @total_div = @monkeys.map(&:test_div).inject(&:*)
  end

  def round(extra_worry = false)
    @monkeys.each do |monkey|
      monkey.items.each do |old|
        monkey.num += 1
        worry = eval("old #{monkey.operation_op} #{monkey.operation_val}")
        worry = extra_worry ? worry % @total_div : worry / 3
        next_monkey = worry % monkey.test_div == 0 ? monkey.if_true : monkey.if_false
        @monkeys[next_monkey].items << worry
      end
      monkey.items = []
    end
  end

  def run
    20.times { round }
    puts @monkeys.map(&:num).sort.last(2).inject(&:*)
  end

  def run_extra_worry
    10000.times { round(true) }
    puts @monkeys.map(&:num).sort.last(2).inject(&:*)
  end
end

KeepAway.new('input-test.txt').run
KeepAway.new('input.txt').run

KeepAway.new('input-test.txt').run_extra_worry
KeepAway.new('input.txt').run_extra_worry