class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station, order_number = -2)
    @stations.insert order_number, station
  end

  def remove_station(station)
    if station != first_station && station != last_station # First and last station cannot be deleted
      @stations.delete_if {|s| s == station}
    end
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
