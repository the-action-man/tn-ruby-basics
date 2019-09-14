require_relative 'train'

class CargoTrain < Train
  def initialize(number, manufacturer)
    super number, :cargo, manufacturer
  end
end
