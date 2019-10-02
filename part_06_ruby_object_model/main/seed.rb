module Seed
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
      's1' => Station.new('s1'),
      's2' => Station.new('s2'),
      's3' => Station.new('s3'),
      's4' => Station.new('s4'),
      's11' => Station.new('s11'),
      's12' => Station.new('s12'),
      's13' => Station.new('s13'),
      's14' => Station.new('s14'),
      's101' => Station.new('s101'),
      's102' => Station.new('s102'),
      's103' => Station.new('s103'),
      's104' => Station.new('s104')
    }

    @routes = {
      'r1' => Route.new('r1', @stations['s1'], @stations['s4']),
      'r11' => Route.new('r11', @stations['s11'], @stations['s14']),
      'r101' => Route.new('r101', @stations['s101'], @stations['s104'])
    }

    @trains = {
      'ct100' => Train.new('ct100', :cargo, 'm1'),
      'ct200' => Train.new('ct200', :cargo, 'm2'),
      'ct300' => Train.new('ct300', :cargo, 'm3'),
      'pt100' => Train.new('pt100', :passenger, 'm1'),
      'pt200' => Train.new('pt200', :passenger, 'm2'),
      'pt300' => Train.new('pt300', :passenger, 'm3')
    }

    @wagons = {
      'cw1' => CargoWagon.new('cw1', 'm1', 100),
      'cw2' => CargoWagon.new('cw2', 'm2', 200),
      'cw3' => CargoWagon.new('cw3', 'm3', 300),
      'pw1' =>
            PassengerWagon.new('pw1', 'm1', 100),
      'pw2' =>
            PassengerWagon.new('pw2', 'm2', 200),
      'pw3' =>
            PassengerWagon.new('pw3', 'm3', 300)
    }
  end
end
