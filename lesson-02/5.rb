puts 'Enter year'
year = gets.chomp.to_i
puts 'Enter month as number'
month = gets.chomp.to_i
puts 'Enter date'
date = gets.chomp.to_i

is_leap_year = false
if year % 4 == 0
  is_leap_year = true
  if year % 100 == 0
    is_leap_year = false
    is_leap_year = true if year % 400 == 0
  end
end

days_in_month = {
    1 => 31,
    2 => 28,
    3 => 31,
    4 => 30,
    5 => 31,
    6 => 30,
    7 => 31,
    8 => 31,
    9 => 30,
    10 => 31,
    11 => 30,
    12 => 31
}

result = 0
i = 1
while i < month
  result += days_in_month[i]
  result += 1 if i == 2 && is_leap_year
  i += 1
end

result += date

puts "Calculated result is #{result}"
