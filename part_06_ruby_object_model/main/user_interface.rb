class UserInterface
  def show_menu
    puts ''
    puts 'Select number of menu item.'
    puts 'Number and appropriate data via spaces. Examples:'
    puts '    1 cargo_train_1'
    puts '    2 route_1 station_1 station_3'
    puts 'Or enter just number if you see ... in the end part of menu item'
    puts ''
    puts 'Menu items:'
    puts '    0- EXIT'
    puts '    1- create_station(name)'
    puts '    2- create_route(name, first_station_name, last_station_name)'
    puts '    3- create_passenger_train...'
    puts '    4- create_cargo_train...'
    puts '    5- add_station_to_route(route_name, station_name)'
    puts '    6- remove_station_from_route(route_name, station_name)'
    puts '    7- take_route_for_train(train_number, route_name)'
    puts '    8- add_wagon_to_train(train_number, wagon_number, ' \
                                          'wagon_manufacturer, volume_or_seats)'
    puts '    9- remove_wagon_from_train(train_number)'
    puts '    10- go_ahead_train(train_number)'
    puts '    11- go_back_train(train_number)'
    puts '    12- show_stations_with_trains'
    puts '    13- take_wagon_seat(wagon_number)'
    puts '    14- take_wagon_volume(wagon_number, volume)'
    puts '    15- show_train(train_number)'
    puts '    100- seed'
    puts '    101- show menu'
  end

  def start
    puts 'Hi! It is RailRoad application!'
    show_menu
    rr = RailRoad.new

    loop do
      puts 'Enter menu item number and data:'
      input = gets.chomp.to_s
      data = input.split(' ')

      selected_menu_item = data[0].to_i
      case selected_menu_item
      when 0
        break
      when 1
        rr.create_station data[1]
      when 2
        rr.create_route data[1], data[2], data[3]
      when 3
        rr.create_passenger_train
      when 4
        rr.create_cargo_train
      when 5
        rr.add_station_to_route data[1], data[2]
      when 6
        rr.remove_station_from_route data[1], data[2]
      when 7
        rr.take_route_for_train data[1], data[2]
      when 8
        rr.add_wagon_to_train data[1], data[2], data[3], data[4]
      when 9
        rr.remove_wagon_from_train data[1]
      when 10
        rr.go_ahead_train data[1]
      when 11
        rr.go_back_train data[1]
      when 12
        puts rr.show_stations_with_trains
      when 13
        puts rr.take_wagon_seat data[1]
      when 14
        puts rr.take_wagon_volume data[1], data[2]
      when 15
        puts rr.show_train data[1]
      when 100
        puts rr.seed
      when 101
        puts show_menu
      else
        puts 'Incorrect selection'
      end
    end
  end
end
