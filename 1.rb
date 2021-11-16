class Station
 attr_accessor :trains, :train_types
 attr_reader :name
 def initialize(name)
  @name = name
  @trains = []
  @train_types = []
 end

 def train_arrive(train)
  self.trains << train
  self.train_types << train.type
 end

 def send_train(train)
  self.trains.delete(train)
  self.train_types(train.type)
 end

 def method_name

 end
end



class Route
 attr_accessor :first, :last, :stations
 def initialize(first, last)
  @first = first
  @last = last
  @stations = [first,last]
 end

 def add_station(station_name)
  self.stations.insert(1, station_name)
 end

 def delete_station(station_name)
  self.stations.delete(station_name) if (station_name != first)&&(station_name != last)
 end

end


class Train
 attr_reader :route
 attr_accessor :speed, :length, :route, :station, :stationprev, :stationnext
 def initialize(number, type, length)
  @number = number
  @type = type
  @length = length
  @speed = 0
 end

 def stop
  self.speed = 0
 end

 def change_length(count)
  self.length += count if (self.speed == 0)&&((count == 1)||(count == -1))
 end

 def change_route(route)
  self.route = route
  self.station = route.stations[0]
  @index = 0
 end

 def change_station(count)
  if ((count == 1)||(count == -1))
   self.station = route.stations[@index+count]
   @index+=count
  end
 end

 def prev_station
  self.stationprev = route.stations[@index - 1]
 end

 def next_station
  self.stationnext = route.stations[@index + 1]
 end

end
