class RailRoad
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = {}
    @routes = {}
    @trains = {}
  end

  def create_station(name)
    @stations[name] = Station.new name
  end

  def create_route(name, first_station_name, last_station_name)
    @routes[name] = Route.new name, @stations[first_station_name], @stations[last_station_name]
  end

  def create_passenger_train(name)
    @trains[name] = PassengerTrain.new name
  end

  def create_cargo_train(name)
    @trains[name] = CargoTrain.new name
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

  def add_wagon_to_train(train_number)
    wagon = CargoWagon.new if @trains[train_number].instance_of? CargoTrain
    wagon = PassengerWagon.new if @trains[train_number].instance_of? PassengerTrain
    @trains[train_number].add_wagon wagon
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

  def get_list_of_stations_and_trains
    data = {}
    @stations.each do |station_name, station|
      data[station_name] = [] unless data.key? station_name
      station.trains.each { |train| data[station.name] << train.number }
    end
    data
  end

  def seed
    create_data
    create_relations
  end

  def create_relations
    @trains[:ct1].take_route @routes[:r1]
  end

  def create_data
    @stations = {
        s1: (Station.new :s1),
        s2: (Station.new :s2),
        s3: (Station.new :s3),
        s4: (Station.new :s4),
        s11: (Station.new :s11),
        s12: (Station.new :s12),
        s13: (Station.new :s13),
        s14: (Station.new :s14),
        s101: (Station.new :s101),
        s102: (Station.new :s102),
        s103: (Station.new :s103),
        s104: (Station.new :s104),
    }

    @routes = {
        r1: (Route.new :r1, @stations[:s1], @stations[:s4]),
        r11: (Route.new :r11, @stations[:s11], @stations[:s14]),
        r101: (Route.new :r101, @stations[:s101], @stations[:s104]),
    }

    @trains = {
        ct1: (CargoTrain.new :ct1),
        ct2: (CargoTrain.new :ct2),
        ct3: (CargoTrain.new :ct3),
        pt1: (PassengerTrain.new :pt1),
        pt2: (PassengerTrain.new :pt2),
        pt3: (PassengerTrain.new :pt3),
    }

    @wagons = {
        cw1: (CargoWagon.new),
        cw2: (CargoWagon.new),
        cw3: (CargoWagon.new),
        pw1: (PassengerWagon.new),
        pw2: (PassengerWagon.new),
        pw3: (PassengerWagon.new),
    }
  end
end