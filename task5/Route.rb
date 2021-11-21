require_relative 'instance_counter'

class Route
  attr_accessor :first, :last, :stations

  include InstanceCounter

  def initialize(first, last)
    @stations = [first,last]
    register_instance
  end

  def add_station(station)
    self.stations.insert(1, station)
  end

  def delete_station(station)
    self.stations.delete(station) if (station != first) && (station != last)
  end

end
