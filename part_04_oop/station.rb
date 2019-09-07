class Station
  attr_reader :trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def do_arrival(train)
    @trains << train
  end

  def do_departure(train)
    @trains.delete train
  end

  def show_trains_by_type
    passengers_trains_quantity = 0
    freight_trains_quantity = 0
    @trains.each do |train|
      passengers_trains_quantity += 1 if train.type == 'passenger'
      freight_trains_quantity += 1 if train.type == 'freight'
    end
    puts "passengers_trains_quantity=#{passengers_trains_quantity}"
    puts "freight_trains_quantity=#{freight_trains_quantity}"
  end
end
