class RailRoad
  include Seed

  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
  end

  def create_station(name)
    @stations[name] = Station.new(name)
  end

  def create_route(name, first_station_name, last_station_name)
    @routes[name] = Route.new(name, \
                              @stations[first_station_name], \
                              @stations[last_station_name])
  end

  def create_passenger_train
    puts 'enter number'
    number = gets.chomp.to_s
    puts 'enter manufacturer'
    manufacturer = gets.chomp.to_s
    @trains[number] = PassengerTrain.new(number, manufacturer)
  rescue RailRoadError => e
    puts e.message
  else
    puts "Passenger train with number '#{number}' is created."
  end

  def create_cargo_train
    puts 'enter name'
    number = gets.chomp.to_s
    puts 'enter manufacturer'
    manufacturer = gets.chomp.to_s
    @trains[number] = CargoTrain.new(number, manufacturer)
  rescue RailRoadError => e
    puts e.message
  else
    puts "Cargo train with number '#{number}' is created."
  end

  def add_station_to_route(route_name, station_name)
    @routes[route_name].add_station @stations[station_name]
  end

  def remove_station_from_route(route_name, station_name)
    @routes[route_name].remove_station @stations[station_name]
  end

  def take_route_for_train(train_number, route_name)
    @trains[train_number].take_route @routes[route_name]
  end

  def add_wagon_to_train(train_number, wagon_number, wagon_manufacturer, \
                         volume_or_seats)
    train = @trains[train_number]
    if train.nil?
      puts "train with number '#{train_number}' is absent"
      return
    end
    case train.type
    when :cargo
      wagon = CargoWagon.new(wagon_number, wagon_manufacturer, \
                             volume_or_seats.to_i)
    when :passenger
      wagon = PassengerWagon.new(wagon_number, \
                                 wagon_manufacturer, volume_or_seats.to_i)
    end
    train.add_wagon(wagon)
  end

  def remove_wagon_from_train(train_number)
    @trains[train_number].remove_last_wagon
  end

  def go_ahead_train(train_number)
    @trains[train_number].go_ahead
  end

  def go_back_train(train_number)
    @trains[train_number].go_back
  end

  def show_stations_with_trains
    @stations.each do |station_name, station|
      puts "'#{station_name}' station:"
      station.each_train do |train|
        puts "  '#{train.number}' train " \
                                     "(type: #{train.type}, " \
                                     "wagons quantity: #{train.wagons.size}):"
        train.show_wagons
      end
    end
  end

  def take_wagon_seat(wagon_number)
    wagon = Wagon.find(wagon_number)
    wagon.take_seat if !wagon.nil? && wagon.type == :passenger
  end

  def take_wagon_volume(wagon_number, volume)
    wagon = Wagon.find(wagon_number)
    wagon.take_volume(volume.to_i) if !wagon.nil? && wagon.type == :cargo
  end

  def show_train(train_number)
    train = Train.find(train_number)
    return if train.nil?

    puts "Train with number #{train.number} has wagons with numbers:"
    train.each_wagon do |wagon|
      puts "    #{wagon.number}"
    end
  end

  def seed
    create_data
    create_relations
  end
end
