require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(manufacturer)
    super :passenger, manufacturer
  end
end
