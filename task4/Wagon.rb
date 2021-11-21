require_relative 'company_name'
class Wagon

  attr_reader :type

  include CompanyName
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
