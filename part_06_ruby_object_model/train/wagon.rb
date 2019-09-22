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

  def initialize(number, type, manufacturer)
    @number = number
    @type = type
    @@instances[number] = self
    self.manufacturer = manufacturer
  end
end
