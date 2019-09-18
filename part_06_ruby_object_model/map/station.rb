class Station
  include InstanceCounter

  @@instances = []
  attr_reader :trains, :name

  def self.all
    @@instances
  end

  def initialize(name)
    validate! name
    @name = name
    @trains = []
    @@instances << self
    register_instance
  end

  def valid?(name)
    validate!  name
    true
  rescue
    false
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

  private

  def validate!(name)
    raise 'name is blank' if name.nil?
  end
end
