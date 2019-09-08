class Station
  attr_reader :trains, :name

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
    trains_by_type = {}
    @trains.each do |train|
      trains_by_type[train.type] = [] unless trains_by_type.key? train.type
      trains_by_type[train.type] << train
    end
    trains_by_type
  end
end
