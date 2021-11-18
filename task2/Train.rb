require_relative 'Route'
require_relative 'Wagon'

class Train
  attr_reader :route, :stationprev, :stationnext, :stationcurrent, :type
  attr_accessor :speed, :route, :station, :number, :wagons
  def initialize(number)
    @number = number
    @speed = 0
    @wagons = []
  end

  def add_wagon(wagon)
    self.wagons << wagon if wagon.type == self.type
  end

  def stop
    self.speed = 0
  end

  def inc_length
    self.length += 1 if train_stopped?
  end

  def dec_length
    self.length -= 1 if train_stopped?
  end

  def change_route(route)
    self.route = route
    self.station = route.stations[0]
  end

  def prev_station
    self.stationprev = route.stations[route.stations.index(station) - 1] if (station != route.first)
  end

  def next_station
    self.stationnext = route.stations[route.stations.index(station) + 1] if (station != route.last)
  end

  def to_next_station
    self.station = next_station if next_station
  end

  def to_prev_station
    self.station = prev_station if prev_station
  end

  def train_stopped?
    speed.zero?
  end

  def unattach_wagon
    @wagons.pop
  end

  protected

  attr_writer :stationprev, :stationnext, :stationcurrent

  def current_station # Пользователь не должен изменять станции в уже сформированном маршруте
    self.stationcurrent = route.stations[route.stations.index(station)]
  end

  def prev_station # Пользователь не должен изменять станции в уже сформированном маршруте
    self.stationprev = route.stations[route.stations.index(station) - 1] if (station != route.first)
  end

  def next_station # Пользователь не должен изменять станции в уже сформированном маршруте
    self.stationnext = route.stations[route.stations.index(station) + 1] if (station != route.last)
  end

end
