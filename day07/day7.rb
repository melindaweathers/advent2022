class FileSystem

  def initialize(filename)
    @files = {'/' => {type: 'dir', children: {}, size: 0}}
    @all_dirs = []
    @current_dir = @files['/']
    IO.readlines(filename)[1..-1].each do |line|
      line.chomp!
      if line == '$ cd ..'
        @current_dir = @current_dir[:parent]
      elsif line.start_with?('$ cd')
        @current_dir = @current_dir[:children][line[5..-1]]
      elsif line.start_with?('dir ')
        @current_dir[:children][line[4..-1]] = {type: 'dir', name: line[4..-1], parent: @current_dir, children: {}, size: 0}
        @all_dirs << @current_dir[:children][line[4..-1]]
      elsif !line.start_with?('$')
        size, name = line.split(' ')
        @current_dir[:children][name] = {type: 'file', name: name, parent: @current_dir, size: size.to_i}
        update_sizes(@current_dir, size.to_i)
      end
    end
  end

  def update_sizes(dir, size)
    dir[:size] += size
    update_sizes(dir[:parent], size) if dir[:parent]
  end

  def small_dir_sizes
    @all_dirs.map{|dir| dir[:size] <= 100000 ? dir[:size] : 0 }.sum
  end

  def dir_to_delete
    used_space = @files['/'][:size]
    free_space = 70000000 - used_space
    space_needed = 30000000 - free_space
    best_so_far = used_space
    @all_dirs.each do |dir|
      best_so_far = dir[:size] if dir[:size] < best_so_far && dir[:size] > space_needed
    end
    best_so_far
  end
end

puts FileSystem.new('input-test.txt').small_dir_sizes
puts FileSystem.new('input.txt').small_dir_sizes

puts FileSystem.new('input-test.txt').dir_to_delete
puts FileSystem.new('input.txt').dir_to_delete
