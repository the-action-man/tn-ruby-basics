class Route
  include InstanceCounter

  ERR_BLANK_NAME = 'name is blank'.freeze
  ERR_ALREADY_EXISTS = 'route already exists'.freeze
  ERR_NIL_START_STATION = 'start_station is nil'.freeze
  ERR_START_STATION_NOT_OBJECT = 'start_station is not Station object'.freeze
  ERR_NIL_FINISH_STATION = 'finish_station is nil'.freeze
  ERR_FINISH_STATION_NOT_OBJECT = 'start_station is not Station object'.freeze
  ERR_SAME_START_FINISH = 'start_station and finish_station are the same'.freeze

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
    @stations = [start_station, finish_station]
    validate!
    @@instances[name] = self
    register_instance
  end

  def valid?
    validate!
    true
  rescue RailRoadError
    false
  end

  def add_station(station, order_number = -2)
    @stations.insert(order_number, station)
  end

  def remove_station(station)
    return if station == first_station || station == last_station

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

  private

  def validate!
    raise RailRoadError, ERR_BLANK_NAME if @name.nil?
    raise RailRoadError, "#{@name} #{ERR_ALREADY_EXISTS}" \
                                            unless Route.find(@name).nil?
    raise RailRoadError, ERR_NIL_START_STATION if first_station.nil?
    raise RailRoadError, ERR_START_STATION_NOT_OBJECT \
                                            unless first_station.is_a?(Station)
    raise RailRoadError, ERR_NIL_FINISH_STATION if last_station.nil?
    raise RailRoadError, ERR_FINISH_STATION_NOT_OBJECT \
                                            unless last_station.is_a?(Station)
    raise RailRoadError, ERR_SAME_START_FINISH if first_station == last_station
  end
end
