require_relative 'wagon'

class PassengerWagon < Wagon
  def initialize(number, manufacturer, seats_quantity)
    super(number, :passenger, manufacturer, seats_quantity)
  end

  def take_seat
    take_space 1
  end

  alias take_seats take_space
  alias available_seats_quantity available_space
  alias taken_seats_quantity taken_space
  alias seats_quantity space_value
end
