require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  def initialize(number)
    super number, :passenger
  end
end
