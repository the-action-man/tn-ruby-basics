require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats_quantity, :taken_seats_quantity

  def initialize(number, manufacturer, seats_quantity)
    super number,:passenger, manufacturer
    @seats_quantity = seats_quantity
    @taken_seats_quantity = 0
  end

  def take_seat
    if @taken_seats_quantity != @seats_quantity
      @taken_seats_quantity += 1
    end
  end

  def available_seats_quantity
    @seats_quantity - @taken_seats_quantity
  end
end
