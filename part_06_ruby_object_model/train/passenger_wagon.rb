require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(number, manufacturer, seats_quantity)
    super number,:passenger, manufacturer, seats_quantity
  end

  def take_seat
    take_space 1
  end

  def available_seats_quantity
    available_space
  end

  def seats_quantity
    space_value
  end

  def taken_seats_quantity
    taken_space
  end
end
