require_relative 'Route'
require_relative 'Train'
require_relative 'Station'
require_relative 'PassengerTrain'
require_relative 'CargoTrain'

class Menu

  def initialize
    @trains = []
    @stations = []
    @station_names = []
    @routes = []
  end

  def main
    print "Выберите категорию:\n"\
          "(1) - действия со станциями\t (2) - действия с поездами\n"\
          "(3) - действия с маршрутами\t (0) - выйти\n"
    key = gets.chomp
    case key
    when '1'
      actions_with_stations
    when '2'
      actions_with_trains
    when '3'
      actions_with_routes
    when '0'
      abort "Выход из программы..."
    end
  end

  private

  def actions_with_stations
    print "Действия со станциями\n"\
          "(1) - создать станцию\t (2) - список станций\n"\
          "(3) - список поездов на станции\t (0) - назад\n"
    key = gets.chomp
    case key
    when '1'
      create_station
      actions_with_stations
    when '2'
      print "#{@station_names}\n"
      actions_with_stations
    when '3'
      trains_on_station
      actions_with_stations
    when '0'
      main
    end
  end

  def actions_with_trains
    print "Действия с поездами\n"\
          "(1) - создать поезд\t (2) - назначить маршрут\n"\
          "(3) - добавить вагон\t (4) - переместить поезд вперед\n"\
          "(5) - переместить поезд назад\t (0) - назад\n"
    key = gets.chomp
    case key
    when '0'
      main
    when '1'
      create_train
      actions_with_trains
    when '2'
      app_route
      actions_with_trains
    when '3'
      add_wagon
      actions_with_trains
    when '4'
      move_train_forward
      actions_with_trains
    when '5'
      move_train_backward
      actions_with_trains
    end
  end

  def actions_with_routes
    print "Действия с маршрутами\n"\
          "(1) - cоздать маршрут\t (2) - добавить станцию в маршрут\n"\
          "(3) - удалить станцию из маршрута\t"\
          "(0)- назад\n"
    key = gets.chomp
    case key
    when '0'
      main
    when '1'
      create_route
      actions_with_routes
    when '2'
      add_station_to_route
      actions_with_routes
    when '3'
      delete_station_from_route
      actions_with_routes
    end
  end

  def create_station
    print "Введите имя станции: "
    name = gets.chomp
    station = Station.new(name)
    @station_names << station
  end

  def trains_on_station
    trains_on_current_station = []
    print "Введите имя станции: "
    name = gets.chomp
    @trains.length.times do |k|
      trains_on_current_station << @trains[k].number if name == @trains[k].stationcurrent
    end
    if trains_on_current_station.length != 0
      print "Номера поездов на текущей станции: \n"\
      "#{trains_on_current_station}"
    else
      print "На этой станции нет поездов\n"
    end
  end


  def create_train
    print "Тип поезда:\n"\
          "(1) - грузовой\t (2) - пассажирский\n"
    pick = gets.chomp
    case pick
    when '1'
      print "Номер поезда:\n"
      train_number = gets.chomp
      train = CargoTrain.new(train_number)
      @trains << train
    when '2'
      print "Номер поезда:\n"
      train_number = gets.chomp
      train = PassengerTrain.new(train_number)
      @trains << train
    end
  end

  def app_route
    print "Номер поезда, для которого хотите назначить маршрут:\n"
    train_number = gets.chomp
    @trains.each do |cur_train|
      if cur_train.number == train_number
        print "Маршрут, который хотите назначить этому поезду: \n"
        @routes.length.times do |k|
          print "(#{k}) - #{@routes[k].stations}\n"
        end
        cur_route = gets.chomp.to_i
        cur_train.choose_route(@routes[cur_route])
      else
        print "Такого поезда не существует\n"
      end
    end
  end

  def add_wagon
    print "Выберите тип вагона:\n"\
          "(1) - грузовой\t (2) - пассажирский\n"
    pick = gets.chomp
    case pick
    when '1'
      wagon = CargoWagon.new
      print "Номер поезда, к которому хотите прикрепить вагон\n"
      train_number = gets.chomp
      @trains.each do |cur_train|
        if cur_train.number == train_number
          current_train = cur_train
          if current_train.type == 'cargo'
            current_train.wagons << wagon
          else
            print "Это не грузовой поезд\n"
          end
        else
          print "Такого поезда не существует\n"
        end
      end
    when '2'
      wagon = PassengerWagon.new
      print "Номер поезда, к которому хотите прикрепить вагон\n"
      train_number = gets.chomp
      @trains.each do |cur_train|
        if cur_train.number == train_number
          current_train = cur_train
          if current_train.type == 'passenger'
            current_train.wagons << wagon
          else
            print "Это не пассажирский поезд"
          end
        else
          print "Такого поезда не существует"
        end
      end
    end
  end

  def remove_wagon
    print "Номер поезда, от которого хотите отсоединить вагон\n"
    train_number = gets.chomp
    @trains.each do |cur_train|
      if cur_train.number == train_number
        cur_train.unattach_wagon
      else
        print "Такого поезда не существует\n"
      end
    end
  end

  def move_train_forward
    print "Введите номер поезда, который хотите переместить вперед: \n"
    train_number = gets.chomp
    @trains.each do |cur_train|
      if cur_train.number == train_number
        if cur_train.next_station == 'final station'
          print "Конечная станция\n"
        else
          cur_train.next_station
        end
      else
        print "Такого поезда не существует\n"
      end
    end
  end

  def move_train_backward
    print "Номер поезда, который хотите переместить назад \n"
    train_number = gets.chomp
    @trains.each do |cur_train|
      if cur_train.number == train_number
        if cur_train.prev_station == 'first station'
          print "Поезд на начальной станции\n"
        else
          cur.train.prev_station
        end
      else
        print "Такого поезда не существует\n"
      end
    end
  end

  def create_route
    print 'Название начальной станции:'
    starting_point = gets.chomp
    if @station_names.include?(starting_point)
      print "Название конечной станции: "
      last_point = gets.chomp
      if @station_names.include?(last_point)
        route = Route.new(starting_point, last_point)
        @routes << route
      else
        print "Такой станции не существует\n"
      end
    else
      print "Такой станции не существует\n"
    end
  end

  def add_station_to_route
     print "Маршрут, к которому хотите добавить промежуточную станцию: \n"
     @routes.length.times do |k|
       print "(#{k}) - #{@routes[k].stations}\n"
     end
     cur_route = gets.chomp.to_i
     print "Название станции: "
     station_name = gets.chomp
     if @station_names.include?(station_name)
       @routes[cur_route].add_station(station_name)
       print "Станция добавлена\n"
     else
       print "Такой станции не существует\n"
     end
   end

  def delete_station_from_route
    print "Маршрут, у которого хотите удалить промежуточную станцию: \n"
    @routes.length.times do |k|
      print "(#{k}) - #{@routes[k].stations}"
    end
    cur_route = gets.chomp.to_i
    print "Введите название станции: "
    station_name = gets.chomp
    if @routes[cur_route].intermediate.include?(station_name)
     @routes[cur_route].delete_station(station_name)
     print "Станция добавлена\n"
   else
      print "Станция не промежуточная\n"
   end
 end
end

  Menu.new.main
