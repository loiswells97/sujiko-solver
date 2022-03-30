require 'set'

def find_sum_options(sum, n, allowed_numbers=(1..9))
  options =[]
  option = []
  if n==1 && allowed_numbers.include?(sum)
    options << [sum]
  else
    allowed_numbers.each do |number|
      if number < sum
        find_sum_options(sum-number, n-1, (number+1..9)).each do |smaller_option|
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
      # puts("Found #{sum_options.length} options")
      options_list << sum_options
  end
  solution_options = options_list[0].product(options_list[1], options_list[2], options_list[3])
  solutions = solution_options.filter{|option| valid_solution?(option, clues)}
  checked_solutions = solutions.map{|option| deduce_answer(option)}.filter{|option| check_clues(option, clues)}
end

def valid_solution?(solution, clues)
  return false unless solution.flatten.to_set == (1..9).to_set
  return false unless (solution[0]&solution[1]&solution[2]&solution[3]).length==1
  return false unless (solution[0]&solution[1]).length==2
  return false unless (solution[0]&solution[2]).length==2
  return false unless (solution[1]&solution[3]).length==2
  return false unless (solution[2]&solution[3]).length==2
  return false unless ((solution[0]&solution[1])+(solution[0]&solution[2])+(solution[1]&solution[3])+(solution[2]&solution[3])).uniq.length==5
  true
end

def check_clues(solution, clues)
  solution.each_with_index do |number, index|
    if clues[index] > 0 && number != clues[index]
      return false
    end
  end
  true
end

def deduce_answer(solution)
  [
    (solution[0]-solution[1]-solution[2])[0],
    ((solution[0]&solution[1])-(solution[0]&solution[1]&solution[2]&solution[3]))[0],
    (solution[1]-solution[0]-solution[3])[0],
    ((solution[0]&solution[2])-(solution[0]&solution[1]&solution[2]&solution[3]))[0],
    (solution[0]&solution[1]&solution[2]&solution[3])[0],
    ((solution[1]&solution[3])-(solution[0]&solution[1]&solution[2]&solution[3]))[0],
    (solution[2]-solution[0]-solution[3])[0],
    ((solution[2]&solution[3])-(solution[0]&solution[1]&solution[2]&solution[3]))[0],
    (solution[3]-solution[1]-solution[2])[0]
  ]
end

solver([6,0,9,0,0,0,5,0,0], [17,15,18,15]).each do |solution|
  puts(solution.inspect)
end
