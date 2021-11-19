require_relative 'Train'
class Station
  attr_accessor :trains
  attr_reader :name
  def initialize(name)
    @name = name
    @trains = []
    @@stations = []
    register_instance
  end

  def self.add_obj(name)
    @@stations << name

  end

  def train_arrive(train)
    self.trains << train
  end

  def send_train(train)
    self.trains.delete(train)
  end

  def self.all
    @@stations
  end

end
