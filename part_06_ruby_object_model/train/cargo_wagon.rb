require_relative 'wagon'

class CargoWagon < Wagon
  def initialize(number, manufacturer, volume)
    super(number, :cargo, manufacturer, volume)
  end

  alias take_volume take_space
  alias available_volume available_space
  alias taken_volume taken_space
  alias volume space_value
end
