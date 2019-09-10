require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  def add_wagon(wagon)
    super(wagon) if passenger_wagon? wagon
  end

  private
  # Добавил метод в приватную секцию так как метод используется для внутреннних нужд класса
  def passenger_wagon?(wagon)
    wagon.instance_of? PassengerWagon
  end
end
