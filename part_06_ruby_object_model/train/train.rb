class Train
  include Manufacturer
  include InstanceCounter
  include Validation

  ALLOWED_NUMBER_FORMAT = /^[a-z\d]{3}-?[a-z\d]{2}$/.freeze
  ALLOWED_TYPE_FORMAT = /^(cargo|passenger)$/.freeze

  @@instances = {}
  attr_reader :number, :type, :speed, :wagons, :route

  validate :number, :presence
  validate :number, :format, ALLOWED_NUMBER_FORMAT
  validate :number, :type, String

  validate :type, :presence
  validate :type, :format, ALLOWED_TYPE_FORMAT
  validate :type, :type, Symbol

  validate :manufacturer, :presence
  validate :manufacturer, :type, String

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

  def start(speed)
    @speed = speed
  end

  def stop
    @speed = 0
  end

  def add_wagon(wagon)
    @wagons << wagon if @speed.zero? && wagon.type == type
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon) if @speed.zero?
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
    next_station = next_station
    return if next_station.nil?

    @station.do_departure self
    @station = next_station
    @station.do_arrival self
  end

  def go_back
    previous_station = previous_station
    return if previous_station.nil?

    @station.do_departure self
    @station = previous_station
    @station.do_arrival self
  end

  def next_station
    @route.get_station_after @station
  end

  def current_station
    @station
  end

  def previous_station
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
        raise RailRoadError, "Unknown wagon type: #{wagon.type}"
      end
      wagon_order += 1
    end
  end
end
