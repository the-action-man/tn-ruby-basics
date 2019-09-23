class Train
  include Manufacturer
  include InstanceCounter

  ALLOWED_NUMBER_SIZE = 6
  ALLOWED_NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/
  ERR_MSG_BLANK_NUMBER = 'number is blank'
  ERR_MSG_TOO_LONG_NUMBER = "number is too long. No more #{ALLOWED_NUMBER_SIZE} symbols are allowed"
  ERR_MSG_WRONG_NUMBER_FORMAT = 'Incorrect number format. Correct examples: 1b3-1b or a2c-d5 or 12345'

  ALLOWED_TYPE_FORMAT = /^(cargo|passenger)$/
  ERR_MSG_BLANK_TYPE = 'type is blank'
  ERR_MSG_WRONG_TYPE_FORMAT = "Incorrect type format. Correct value example: 'cargo', 'passenger'."

  ALLOWED_MANUFACTURER_SIZE = 15
  ERR_MSG_BLANK_MANUFACTURER = 'manufacturer is blank'
  ERR_MSG_TOO_LONG_MANUFACTURER = "manufacturer is too long. No more #{ALLOWED_MANUFACTURER_SIZE} symbols are allowed"

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
    @number = number
    @type = type
    @speed = 0
    @wagons = []
    @manufacturer = manufacturer
    validate!
    @@instances[number] = self
    register_instance
  end

  def valid?
    validate!
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

  def each_wagon
    @wagons.each { |wagon| yield wagon }
  end

  def show_wagons
    wagon_order = 1
    each_wagon do |wagon|
      puts "    #{wagon_order}: '#{wagon.number}' wagon - type: #{wagon.type})"
      case wagon.type
      when :cargo
        puts "      available volume: #{wagon.available_volume}"
        puts "      taken volume: #{wagon.taken_volume}"
      when :passenger
        puts "      available seats: #{wagon.available_seats_quantity}"
        puts "      taken seats: #{wagon.taken_seats_quantity}"
      else
        raise Exception "Unknown wagon type: #{wagon.type}"
      end
      wagon_order += 1
    end
  end

  private

  def validate!
    raise ERR_MSG_BLANK_NUMBER if @number.nil?
    raise ERR_MSG_TOO_LONG_NUMBER if @number.size > ALLOWED_NUMBER_SIZE
    raise ERR_MSG_WRONG_NUMBER_FORMAT if @number !~ ALLOWED_NUMBER_FORMAT

    raise ERR_MSG_BLANK_TYPE if @type.nil?
    raise ERR_MSG_WRONG_TYPE_FORMAT if @type !~ ALLOWED_TYPE_FORMAT

    raise ERR_MSG_BLANK_MANUFACTURER if @manufacturer.nil?
    raise ERR_MSG_TOO_LONG_MANUFACTURER if @manufacturer.size > ALLOWED_MANUFACTURER_SIZE
  end
end
