class Station
  include InstanceCounter
  include Validation

  validate :name, :presence
  validate :name, :type, String

  @@instances = {}
  attr_reader :trains, :name

  def self.all
    @@instances
  end

  def self.find(name)
    @@instances[name]
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@instances[name] = self
    register_instance
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

  def each_train
    @trains.each { |tran| yield tran }
  end
end
