def find_sum_options(sum, n)
  options =[]
  option = []
  if n==1 && (1..9).include?(sum)
    options << [sum]
  else
    (1..9).each do |number|
      if number < sum
        find_sum_options(sum-number, n-1).each do |smaller_option|
          option = [number] + smaller_option
          if option.uniq.length == option.length
            options << option
          end
        end
      else
        break
      end
    end
  end
  options
end

def solver(clues, sums)
  options_list = []
    sums.each do |sum|
      sum_options = find_sum_options(sum, 4)
      puts("Found #{sum_options.length} options")
      options_list << sum_options
  end
  puts("Combining options")
  solution_options = options_list[0].product(options_list[1], options_list[2], options_list[3])
  puts("Checking validity")
  solutions = solutions_options.filter(option => valid_solution?(option, clues))
end

# find_sum_options(17,2).each do |option|
#   puts(option)
#   puts('\n')
#   puts('\n')
# end

def valid_solution?(solution, clues)
  return false unless solution.flatten.to_set == (1..9).to_set
  clues.each_with_index do |clue, index|
    return false unless clue==0 || flattened_solution(solution)[index] == clue
  end
  return false unless solution[0,1]==solution[1,0]
  return false unless solution[0,2]==solution[2,0]
  return false unless solution[0,3]==solution[3,0]
  return false unless solution[1,2]==solution[2,1]
  return false unless solution[1,3]==solution[3,1]
  return false unless solution[2,3]==solution[3,2]
  true
end

def flattened_solution(solution)
  [
    solution[0,0],
    solution[0,1],
    solution[1,1],
    solution[0,2],
    solution[0,3],
    solution[1,3],
    solution[2,2],
    solution[2,3],
    solution[3,3]
  ]
end
#
# find_sum_options(10,4).each do |option|
#   puts('\n\n')
#   puts(option)
# end
# puts("\n\n\n\n")
#
# find_sum_options(21,4).each do |option|
#   puts('\n\n')
#   puts(option)
# end
# puts("\n\n\n\n")
#
# find_sum_options(18,4).each do |option|
#   puts('\n\n')
#   puts(option)
# end
# puts("\n\n\n\n")
#
# find_sum_options(20,4).each do |option|
#   puts('\n\n')
#   puts(option)
# end
# puts("\n\n\n\n")


solver([0,0,0,0,0,0,8,0,7], [10,21,18,20])
