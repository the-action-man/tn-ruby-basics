require_relative 'train'

class PassengerTrain < Train
  def initialize(number, manufacturer)
    super number, :passenger, manufacturer
  end
end
