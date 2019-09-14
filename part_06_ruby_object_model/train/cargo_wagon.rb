require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(manufacturer)
    super :cargo, manufacturer
  end
end
