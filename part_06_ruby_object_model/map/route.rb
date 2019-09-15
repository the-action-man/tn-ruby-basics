class Route
  include InstanceCounter

  attr_reader :name, :stations

  def initialize(name, start_station, finish_station)
    @name = name
    @stations = [start_station, finish_station]
    register_instance self
  end

  def add_station(station, order_number = -2)
    @stations.insert order_number, station
  end

  def remove_station(station)
    @stations.delete_if {|s| s == station} if station != first_station && station != last_station
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end

  def get_station_after(station)
    if station != last_station # The next station is absent if the train is on the last station.
      index = @stations.index station
      @stations[index + 1]
    end
  end

  def get_station_before(station)
    if station != first_station # The previous station is absent if the train is on the first station.
      index = @stations.index station
      @stations[index - 1]
    end
  end
end
