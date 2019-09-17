########################################
puts 'before'
begin
  Math.sqrt(-1)
rescue Exception
  puts 'rescue'
else
  puts 'else'
ensure
  puts 'ensure'
end
puts 'after'
########################################

