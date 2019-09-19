class Route
  include InstanceCounter

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
  rescue
    false
  end

  def add_station(station, order_number = -2)
    @stations.insert(order_number, station)
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

  ERR_BLANK_NAME = 'name is blank'
  ERR_ALREADY_EXISTS = "#{@name} route already exists"
  ERR_NIL_START_STATION = 'start_station is nil'
  ERR_START_STATION_NOT_OBJECT = 'start_station is not Station object'
  ERR_NIL_FINISH_STATION = 'finish_station is nil'
  ERR_FINISH_STATION_NOT_OBJECT = 'start_station is not Station object'
  ERR_SAME_START_FINISH = 'start_station and finish_station are the same'

  def validate!
    raise ERR_BLANK_NAME if @name.nil?
    raise ERR_ALREADY_EXISTS unless Route.find(@name).nil?
    raise ERR_NIL_START_STATION if first_station.nil?
    raise ERR_START_STATION_NOT_OBJECT unless first_station.is_a?(Station)
    raise ERR_NIL_FINISH_STATION if last_station.nil?
    raise ERR_FINISH_STATION_NOT_OBJECT unless last_station.is_a?(Station)
    raise ERR_SAME_START_FINISH if first_station == last_station
  end
end
