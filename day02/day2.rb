def calc_score(filename, decode_outcome = false)
  IO.readlines(filename).map do |line|
    opp, resp = line.split(' ')
    opp, resp = opp.ord - 65, resp.ord - 88
    resp = (opp + resp - 1) % 3 if decode_outcome
    (resp + 1) + (((resp - opp + 1) % 3) * 3)
  end.sum
end

puts calc_score('input-test.txt')
puts calc_score('input.txt')

puts 'round two'
puts calc_score('input-test.txt', true)
puts calc_score('input.txt', true)