class Train
  attr_accessor :speed
  attr_reader :wagons_quantity
  attr_reader :type

  def initialize(number, type, wagons_quantity)
    @number = number
    @type = type
    @wagons_quantity = wagons_quantity
    self.speed = 0
  end

  def start(speed)
    self.speed = speed
  end

  def stop
    self.speed = 0
  end

  def add_wagon
    if self.speed == 0
      @wagons_quantity += 1
    else
      puts "Wagon cannot be added because train is not stopped"
    end
  end

  def remove_wagon
    if self.speed == 0
      @wagons_quantity -= 1
    else
      puts "Wagon cannot be removed because train is not stopped"
    end
  end

  def take_route(route)
    @route = route
    @station = route.first_station
    @station.do_arrival self
  end

  def go_ahead
    @station.do_departure self
    @station = get_next_station
    @station.do_arrival self
  end

  def go_back
    @station.do_departure self
    @station = get_previous_station
    @station.do_arrival self
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
