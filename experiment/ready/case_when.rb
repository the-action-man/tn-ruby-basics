# ############################
# Example 1
# ############################

# n = 5 # => X
# n = 2 # => Y
# n = 9 # => Y
n = 10 # => Z

case n
when 5
  puts 'X'
when 2, 9
  puts 'Y'
else
  puts 'Z'
end

# ############################
# Example 2
# ############################
n = 1 # => X
def m(n)
  case n
  when 1
    puts 'X'
  when 1
    puts 'Y'
  else
    puts 'Z'
  end
end





