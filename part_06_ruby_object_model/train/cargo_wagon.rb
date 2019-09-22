require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume, :taken_volume

  def initialize(number, manufacturer, volume)
    super number,:cargo, manufacturer
    @volume = volume
    @taken_volume = 0
  end

  def take_volume(volume_to_take)
    if volume_to_take + @taken_volume <= @volume
      @taken_volume += volume_to_take
    end
  end

  def available_volume
    @volume - @taken_volume
  end
end
