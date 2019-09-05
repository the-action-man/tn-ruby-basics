numbers = [0]
next_number = 1

while next_number <= 100
  numbers << next_number
  next_number = numbers[-1] + numbers[-2]
end

puts numbers