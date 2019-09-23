class RailRoad
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
    @routes[name] = Route.new name, @stations[first_station_name], @stations[last_station_name]
  end

  def create_passenger_train
    puts 'enter number'
    number = gets.chomp.to_s
    puts 'enter manufacturer'
    manufacturer = gets.chomp.to_s
    @trains[number] = PassengerTrain.new(number, manufacturer)
  rescue Exception => e
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
  rescue Exception => e
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

  def add_wagon_to_train(train_number, wagon_number, wagon_manufacturer, volume_or_seats)
    wagon = CargoWagon.new(wagon_number, wagon_manufacturer, volume_or_seats) if @trains[train_number].instance_of? CargoTrain
    wagon = PassengerWagon.new(wagon_number, wagon_manufacturer, volume_or_seats) if @trains[train_number].instance_of? PassengerTrain
    @trains[train_number].add_wagon(wagon)
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
        puts "  '#{train.number}' train (type: #{train.type}, wagons quantity: #{train.wagons.size}):"
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
    unless train.nil?
      puts "Train with number #{train.number} has wagons with numbers:"
      train.each_wagon do |wagon|
        puts "    #{wagon.number}"
      end
    end
  end

  def seed
    create_data
    create_relations
  end

  def create_relations
    @trains['ct100'].take_route @routes['r1']
    @trains['ct200'].take_route @routes['r1']
    @trains['ct300'].take_route @routes['r1']

    @trains['ct100'].add_wagon @wagons['cw1']
    @trains['ct100'].add_wagon @wagons['cw2']
    @trains['ct100'].add_wagon @wagons['cw3']

    @trains['pt100'].take_route @routes['r11']
    @trains['pt200'].take_route @routes['r11']
    @trains['pt300'].take_route @routes['r11']

    @trains['pt100'].add_wagon @wagons['pw1']
    @trains['pt100'].add_wagon @wagons['pw2']
    @trains['pt100'].add_wagon @wagons['pw3']
  end

  def create_data
    @stations = {
        's1' => (Station.new 's1'),
        's2' => (Station.new 's2'),
        's3' => (Station.new 's3'),
        's4' => (Station.new 's4'),
        's11' => (Station.new 's11'),
        's12' => (Station.new 's12'),
        's13' => (Station.new 's13'),
        's14' => (Station.new 's14'),
        's101' => (Station.new 's101'),
        's102' => (Station.new 's102'),
        's103' => (Station.new 's103'),
        's104' => (Station.new 's104')
    }

    @routes = {
        'r1' => (Route.new 'r1', @stations['s1'], @stations['s4']),
        'r11' => (Route.new 'r11', @stations['s11'], @stations['s14']),
        'r101' => (Route.new 'r101', @stations['s101'], @stations['s104'])
    }

    @trains = {
        'ct100' => (CargoTrain.new 'ct100', 'm1'),
        'ct200' => (CargoTrain.new 'ct200', 'm2'),
        'ct300' => (CargoTrain.new 'ct300', 'm3'),
        'pt100' => (PassengerTrain.new 'pt100', 'm1'),
        'pt200' => (PassengerTrain.new 'pt200', 'm2'),
        'pt300' => (PassengerTrain.new 'pt300', 'm3')
    }

    @wagons = {
        'cw1' => (CargoWagon.new 'cw1', 'm1', 100),
        'cw2' => (CargoWagon.new 'cw2','m2', 200),
        'cw3' => (CargoWagon.new 'cw3','m3', 300),
        'pw1' => (PassengerWagon.new 'pw1', 'm1', 100),
        'pw2' => (PassengerWagon.new 'pw2', 'm2', 200),
        'pw3' => (PassengerWagon.new 'pw3','m3', 300)
    }
  end
end
