class Route
  include InstanceCounter
  include Validation

  validate :name, :presence
  validate :name, :type, String
  validate :start_station, :type, Station
  validate :finish_station, :type, Station

  @@instances = {}
  attr_reader :name, :stations

  def self.all
    @@instances
  end

  def self.find(name)
    @@instances[name]
  end

  def initialize(name, start_station, finish_station)
    @name = name
    @start_station = start_station
    @finish_station = finish_station
    validate!
    @stations = [@start_station, @finish_station]
    @@instances[name] = self
    register_instance
  end

  def add_station(station, order_number = -2)
    @stations.insert(order_number, station)
  end

  def remove_station(station)
    return if [first_station, last_station].include?(station)

    @stations.delete_if { |s| s == station }
  end

  def first_station
    @stations[0]
  end

  def last_station
    @stations[-1]
  end

  def get_station_after(station)
    return if station == last_station

    index = @stations.index station
    @stations[index + 1]
  end

  def get_station_before(station)
    return if station == first_station

    index = @stations.index station
    @stations[index - 1]
  end
end
