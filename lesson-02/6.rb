h = Hash.new
loop do
  puts "Enter product name"
  name = gets.chomp
  break if name == "stop"

  puts "Enter price"
  price = gets.chomp.to_f

  puts "Enter quantity"
  quantity = gets.chomp.to_i

  h[name] = {price: price, quantity: quantity}
end

total_price = 0
h.each do |name, info|
  puts "   *** Product: #{name} ***"
  price = info[:price]
  quantity = info[:quantity]

  puts "price = #{price}, quantity = #{quantity}"
  total_price_per_product = price * quantity

  puts "total price per product = #{total_price_per_product}"
  total_price += total_price_per_product
end

puts "total price = #{total_price}"
