class Car1
  def speed(speed)
    self.speed = speed
  end

  def speed
    self.speed
  end

  private
  attr_accessor :speed
end
