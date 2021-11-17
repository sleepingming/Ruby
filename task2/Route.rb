class Route
  attr_accessor :first, :last, :stations
  def initialize(first, last)
    @stations = [first,last]
  end

  def add_station(station)
    self.stations.insert(1, station)
  end

  def delete_station(station)
    self.stations.delete(station) if station_first? && station_last?
  end

  private

  def station_first?
    (station != first).zero?
  end

  def station_last?
    (station != last).zero?
  end

end
