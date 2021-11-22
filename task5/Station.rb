require_relative 'Train'
require_relative 'instance_counter'
class Station
  attr_accessor :trains
  attr_reader :name

  include InstanceCounter

  STATION_NAME_FORMAT = /^[a-z]+$/i
  def initialize(name)
    @name = name
    @trains = []
    @@stations = []
    validate_name!
    register_instance
  end

  def trains_on_station
    Train.@trains.each do |train|
      yield(train)
    end
  end

  def self.add_obj(name)
    @@stations << name

  end

  def self.all
    @@stations
  end

  def valid?
    validate_name!
    true
  rescue StandartError
    false
  end

  protected

  def validate_name!
    raise "Вы ничего не ввели\n" if name.length.zero?
    raise "Некорректное имя\n" if name !~ STATION_NAME_FORMAT
  end

end
