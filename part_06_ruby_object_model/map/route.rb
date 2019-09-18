class Route
  include InstanceCounter

  attr_reader :name, :stations

  def initialize(name, start_station_name, finish_station_name)
    validate! name, start_station_name, finish_station_name
    @name = name
    @stations = [start_station_name, finish_station_name]
    register_instance
  end

  def valid?(name, start_station_name, finish_station_name)
    validate! name, start_station_name, finish_station_name
    true
  rescue
    false
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

  private

  def validate!(name, start_station_name, finish_station_name)
    raise 'name is blank' if name.nil?
    raise 'start_station_name is blank' if start_station_name.nil?
    raise 'finish_station_name is blank' if finish_station_name.nil?
  end
end
