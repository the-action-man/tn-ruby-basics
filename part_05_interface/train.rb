class Train
  attr_reader :number, :speed, :wagons, :route

  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
  end

  def start(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed == 0
      @wagons << wagon
    end
  end

  def remove_wagon(wagon)
    if @speed == 0
      @wagons.delete wagon
    end
  end

  def remove_last_wagon
    remove_wagon @wagons[-1]
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
