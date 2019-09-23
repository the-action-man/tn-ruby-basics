class Wagon
  include Manufacturer

  @@instances = {}
  attr_reader :number, :type

  class << self
    def all
      @@instances
    end

    def find(number)
      @@instances[number]
    end
  end

  def initialize(number, type, manufacturer, space_value)
    @number = number
    @type = type
    @@instances[number] = self
    self.manufacturer = manufacturer
    @space_value = space_value
    @taken_space = 0
  end

  protected

  attr_reader :space_value, :taken_space

  def take_space(space_to_take)
    if space_to_take + @taken_space <= @space_value
      @taken_space += space_to_take
    end
  end

  def available_space
    @space_value - @taken_space
  end
end
