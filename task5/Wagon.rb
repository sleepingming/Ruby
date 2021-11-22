require_relative 'company_name'
class Wagon

  attr_accessor :capacity
  attr_reader :type

  include CompanyName
end

class CargoWagon < Wagon
  attr_reader :occupied_capacity

  def take_up_volume(volume)
    if @capacity - volume >= 0
      @capacity -= volume
      @occupied_capacity += volume
    end
  end

  protected
  def initialize(capacity)
    @type = 'cargo'
    @capacity = capacity
    @occupied_capacity = 0

  end
end

class PassengerWagon < Wagon
  attr_reader :occupied_places

  def take_a_place
    if @capacity.zero?
      nil
    else
      @capacity -= 1
      @occupied_places += 1
    end
  end

  protected
  def initialize(capacity)
    @type = 'passenger'
    @capacity = capacity
    @occupied_places = 0
  end
end
