require_relative 'Train'
require_relative 'instance_counter'
require_relative 'validation'
class Station
  attr_accessor :trains
  attr_reader :name

  include InstanceCounter

  STATION_NAME_FORMAT = /^[a-z]+$/i
  include Validation
  validate :name, :format, STATION_NAME_FORMAT
  validate :name, :presence
  def initialize(name)
    @name = name
    @trains = []
    @@stations = []
    validate_name!
    register_instance
  end

  def trains_on_station
    @trains.each do |train|
      yield(train)
    end
  end

  def self.add_obj(name)
    @@stations << name

  end

  def self.all
    @@stations
  end


end
