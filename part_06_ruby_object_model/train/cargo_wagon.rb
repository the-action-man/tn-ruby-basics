require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(number, manufacturer, volume)
    super number,:cargo, manufacturer, volume
  end

  def take_volume(volume_to_take)
    take_space volume_to_take
  end

  def available_volume
    available_space
  end

  def taken_volume
    taken_space
  end

  def volume
    space_value
  end
end
