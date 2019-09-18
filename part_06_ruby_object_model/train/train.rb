class Train
  include Manufacturer
  include InstanceCounter

  @@instances = {}
  attr_reader :number, :type, :speed, :wagons, :route

  class << self
    def all
      @@instances
    end

    def find(number)
      @@instances[number]
    end
  end

  def initialize(number, type, manufacturer)
    validate! number, type, manufacturer
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    self.manufacturer = manufacturer
    @@instances[number] = self
    register_instance
  end

  def valid?(number, type, manufacturer)
    validate! number, type, manufacturer
    true
  rescue
    false
  end

  def start(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    if @speed == 0 && wagon.type == self.type
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

  private

  def validate!(number, type, manufacturer)
    raise 'number is blank' if number.nil?
    allowed_number_size = 6
    raise "number is too long. No more #{allowed_number_size} symbols are allowed" if number.size > allowed_number_size
    raise 'Incorrect number format. Correct examples: 1b3-1b or a2c-d5 or 12345' if number !~ /^(\d|[a-z]){3}(-|)(\d|[a-z]){2}$/

    raise 'type is blank' if type.nil?
    raise "Incorrect type format. Correct value example: 'cargo', 'passenger'." if type !~ /^(cargo|passenger)$/

    raise 'manufacturer is blank' if manufacturer.nil?
    allowed_manufacturer_size = 15
    raise "manufacturer is too long. No more #{allowed_manufacturer_size} symbols are allowed" if number.size > allowed_manufacturer_size
  end
end
