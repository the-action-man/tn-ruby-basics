puts 'Enter a'
a = gets.to_f

puts 'Enter b'
b = gets.to_f

puts 'Enter c'
c = gets.to_f


d = (b**2 - 4*a*c)


if d < 0
	puts "нет решения"
else
	if d == 0
		c = 0
		# Х1 = Х2 = –b/(2a)
		x1 = -b / 2*a
		x2 = x1
	else
		c = Math.sqrt(d)
		# х1 = (–b + C)/(2a)
		x1 = (-b + c) / (2*a)
		# x2 = (–b – C)/(2a)
		x2 = (-b - c)  / (2*a)
	end

	puts "x1 = #{x1}"
	puts "x2 = #{x2}"
end
