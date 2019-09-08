class Train
  attr_reader :speed, :wagons_quantity, :type

  def initialize(number, type, wagons_quantity)
    @number = number
    @type = type
    @wagons_quantity = wagons_quantity
    @speed = 0
  end

  def start(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon
    if @speed == 0
      @wagons_quantity += 1
    else
      nil # Wagon cannot be added because train is not stopped
    end
  end

  def remove_wagon
    if @speed == 0
      @wagons_quantity -= 1
    else
      nil # Wagon cannot be removed because train is not stopped
    end
  end

  def take_route(route)
    @route = route
    @station = route.first_station
    @station.do_arrival self
  end

  def go_ahead
    next_station = get_next_station
    unless next_station.nil?
      @station.do_departure self
      @station = next_station
      @station.do_arrival self
    end
  end

  def go_back
    previous_station = get_previous_station
    unless previous_station.nil?
      @station.do_departure self
      @station = previous_station
      @station.do_arrival self
    end
  end

  def get_next_station
    @route.get_station_after @station
  end

  def get_current_station
    @station
  end

  def get_previous_station
    @route.get_station_before @station
  end
end
