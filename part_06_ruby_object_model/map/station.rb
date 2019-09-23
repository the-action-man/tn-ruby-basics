class Station
  include InstanceCounter

  ERR_BLANK_NAME = 'name is blank'
  ERR_ALREADY_EXISTS = "station already exists"

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

  def valid?
    validate!
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

  def each_train
    @trains.each { |tran| yield tran }
  end

  private

  def validate!
    raise ERR_BLANK_NAME if @name.nil?
    raise "#{@name} #{ERR_ALREADY_EXISTS}" unless Station.find(@name).nil?
  end
end
