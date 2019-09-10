require_relative 'cargo_train'
require_relative 'cargo_wagon'
require_relative 'passenger_train'
require_relative 'passenger_wagon'
require_relative 'route'
require_relative 'station'
require_relative 'train'
require_relative 'wagon'
require_relative 'rail_road'

class UserInterface

  def show_menu
    puts 'Select number of menu item.'
    puts 'Number and appropriate data via spaces. Examples:'
    puts '    1 cargo_train_1'
    puts '    2 route_1 station_1 station_3'
    puts 'Menu items:'
    puts '0- EXIT'
    puts '1- create_station(name)'
    puts '2- create_route(name, first_station_name, last_station_name)'
    puts '3- create_passenger_train(name)'
    puts '4- create_cargo_train(name)'
    puts '5- add_station_to_route(route_name, station_name)'
    puts '6- remove_station_from_route(route_name, station_name)'
    puts '7- take_route_for_train(train_number, route_name)'
    puts '8- add_wagon_to_train(train_number)'
    puts '9- remove_wagon_from_train(train_number)'
    puts '10- go_ahead_train(train_number)'
    puts '11- go_back_train(train_number)'
    puts '12- get_list_of_stations_and_trains'
    puts 'Enter number:'
  end

  def start
    puts 'Hi! It is RailRoad application!'
    rr = RailRoad.new

    loop do
      show_menu
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
        rr.create_passenger_train data[1]
      when 4
        rr.create_cargo_train data[1]
      when 5
        rr.add_station_to_route data[1], data[2]
      when 6
        rr.remove_station_from_route data[1], data[2]
      when 7
        rr.take_route_for_train data[1], data[2]
      when 8
        rr.add_wagon_to_train data[1]
      when 9
        rr.remove_wagon_from_train data[1]
      when 10
        rr.go_ahead_train data[1]
      when 11
        rr.go_back_train data[1]
      when 12
        puts rr.get_list_of_stations_and_trains
      else
        puts 'Incorrect selection'
      end
    end
  end
end

ui = UserInterface.new
ui.start
