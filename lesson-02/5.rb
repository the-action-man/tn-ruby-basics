puts 'Enter year'
year = gets.chomp.to_i
puts 'Enter month as number'
month = gets.chomp.to_i
puts 'Enter date'
date = gets.chomp.to_i

is_leap_year = false
is_leap_year = true if (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)

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
days_in_month[2] = 29 if is_leap_year

days_of_months_to_calc = days_in_month.values.take(month - 1)
result = days_of_months_to_calc.sum
result += date

puts "Calculated result is #{result}"
