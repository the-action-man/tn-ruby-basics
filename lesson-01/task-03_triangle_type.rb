puts 'Enter size 1'
size_1 = gets.to_f

puts 'Enter size 2'
size_2 = gets.to_f

puts 'Enter size 3'
size_3 = gets.to_f

usual_size_1, usual_size_2, biggest_size = [size_1, size_2, size_3].sort

if biggest_size ** 2 == usual_size_1 ** 2 + usual_size_2 ** 2
  puts 'Right triangle (Прямоугольный треугольник)'
elsif size_1 == size_2 && size_2 == size_3
  puts 'equilateral triangle (равносторонний)'
elsif size_1 == size_2 || size_1 == size_3 || size_2 == size_3
  puts 'isosceles triangle (равнобедренный)'
else
  puts 'usual triangle (обычный)'
end
