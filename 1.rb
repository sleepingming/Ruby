class Station
  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrive(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

end



class Route
  attr_accessor :first, :last, :stations
  def initialize(first, last)
    @stations = [first,last]
  end

  def add_station(station)
    self.stations.insert(1, station)
  end

  def delete_station(station)
    self.stations.delete(station) if (station != first) && (station != last)
  end

end


class Train
  attr_reader :route
  attr_accessor :speed, :length, :route, :station, :stationprev, :stationnext, :stationcurrent
  def initialize(number, type, length)
    @number = number
    @type = type
    @length = length
    @speed = 0
  end

  def stop
    self.speed = 0
  end

  def inc_length
    self.length += 1 if (self.speed == 0)
  end

  def dec_length
    self.length -= 1 if (self.speed == 0)
  end

  def change_route(route)
    self.route = route
    self.station = route.stations[0]
  end

  def current_station
    self.stationcurrent = route.stations[route.stations.index(station)]
  end

  def prev_station
    self.stationprev = route.stations[route.stations.index(station) - 1] if (station != route.first)
  end

  def next_station
    self.stationnext = route.stations[route.stations.index(station) + 1] if (station != route.last)
  end

  def to_next_station
    self.station = route.stations[route.stations.index(station) + 1] if (station != route.last)
  end

  def to_prev_station
    self.station = route.stations[route.stations.index(station) - 1] if (station != route.first)
  end

end
