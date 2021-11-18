class Wagon

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
