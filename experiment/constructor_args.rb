class A
  def initialize(a, b)
    @a = a
    @b = b
  end
end

class B
  attr_writer :a, :b
  def initialize(args)
    args.each { |key, value| self.send( "#{key}=", value) }
  end
end
puts 'A:'
a = A.new 1, 2
puts a.instance_variables

puts 'B:'
b = B.new a: 1, b: 2
puts b.instance_variables
##########
# OUTPUT
# ########
# A:
# @a
# @b
# B:
# @a
# @b
#
