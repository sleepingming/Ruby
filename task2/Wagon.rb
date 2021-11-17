class Wagon

  protected # Чтобы эти методы не было доступны для пользователя и чтобы использовать type в подклассах

  attr_reader :type
end

class CargoWagon < Wagon
  protected
  def initialize
    @type = 'cargo'
  end
end

class PassengerWagon < Wagon
  protected
  def initialize
    @type = 'passenger'
  end
end
