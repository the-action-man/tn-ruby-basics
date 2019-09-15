# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# Experiment to verify constant and variables: local, instance, class
#
# CONCLUSION:
# @i_v in class and in initialize are different variables:
# --- 1 ---
# VarExp.my_class_method => @i_v = 10
# --- 2 ---
# e = varExp.new
# e.my_instance_method => @i_v = 20
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
class VarExp
  MY_CONSTANT = -1  # constant
  l_v = 0           # local variable
  @i_v = 10         # instance variable
  @@c_v = 100       # class variable

  def self.my_class_method
    puts 'my class method !!!'
    puts "MY_CONSTANT = #{MY_CONSTANT}"
    # puts "l_v = #{l_v}" # NOT ACCESSIBLE
    puts "@i_v = #{@i_v}"
    puts "@@c_v = #{@@c_v}"
  end

  def initialize
    @i_v = 20
  end

  def my_instance_method
    puts 'my instance method !!!'
    puts "MY_CONSTANT = #{MY_CONSTANT}"
    # puts "@l_v = #{l_v}" # NOT ACCESSIBLE
    puts "@i_v = #{@i_v}"
    puts "@@c_v = #{@@c_v}"
  end

  puts "MY_CONSTANT = #{MY_CONSTANT}"
  puts "@l_v = #{l_v}"
  puts "@i_v = #{@i_v}"
  puts "@@c_v = #{@@c_v}"

  my_class_method
end
