require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  def initialize(number)
    super number, :cargo
  end
end
