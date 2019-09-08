class Route
  attr_reader :stations

  def initialize(start_station, finish_station)
    @stations = [start_station, finish_station]
  end

  def add_station(station, order_number = -2)
    @stations.insert order_number, station
  end

  def remove_station(station)
    if station == first_station
      nil # First station cannot be deleted
    elsif station == last_station
      nil # Last station cannot be deleted
    else
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
    if station == last_station
      nil # The train is on the last station. The next station is absent.
    else
      index = @stations.index station
      @stations[index + 1]
    end
  end

  def get_station_before(station)
    if station == first_station
      nil # The train is on the first station. The previous station is absent.
    else
      index = @stations.index station
      @stations[index - 1]
    end
  end
end
