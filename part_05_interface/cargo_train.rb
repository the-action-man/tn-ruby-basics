require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  def add_wagon(wagon)
    super(wagon) if cargo_wagon? wagon
  end

  private
  # Добавил метод в приватную секцию так как метод используется для внутреннних нужд класса
  def cargo_wagon?(wagon)
    wagon.instance_of? CargoWagon
  end
end
