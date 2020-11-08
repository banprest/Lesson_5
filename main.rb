require_relative 'name_manufacturing_company.rb'
require_relative 'instance_counter.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'train.rb'
require_relative 'cargo_train.rb'
require_relative 'passenger_train.rb'
require_relative 'railcar.rb'
require_relative 'cargo_railcar.rb'
require_relative 'passenger_railcar.rb'


class Main
  attr_reader :stations, :routes, :trains,

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def menu
    loop do
      puts 'Для создания станции введите - 0.
      Для создания поезда введите - 1.
      Для создания маршрута введите 2.
      Для того чтобы добавить станцию к маршруту введите 3.
      Для того чтобы удалить станцию из маршрута введите 4.
      Для того чтобы назаначить маршрут поузду введите 5.
      Для того чтобы добавить вагон к поезду введите 6.
      Для того чтобы отцепить вагон от поезда введите 7.
      Для того чтобы переместить поезд вперед введите 8.
      Для того чтобы переместить поезд назад введите 9.
      Чтобы просмотреть список станций введите 10.
      Чтобы просмотреть список поездов введите 11.
      Чтобы посмотреть список вагонов введите 12
      Чтобы изменить обьём или места в вагоне введите 13 '

      choise = gets.chomp

      case choise
      when '0'
        create_station
      when '1'
        create_train_in_error
      when '2'
        create_route
      when '3'
        add_station_to_route
      when '4'
        delete_station_to_route
      when '5'
        add_train_to_road
      when '6'
        add_railcar_to_train
      when '7'
        delete_railcar_to_train
      when '8'
        move_train_forward
      when '9' 
        move_train_back
      when '10'
        show_station
      when '11'
        show_train_in_station
      when '12'
        show_railcar_in_train
      when '13'
        take_place_or_volume
      else 
        puts 'EROR'
      end
    puts 'Чтобы выйти из текстового интерфейса введите "да"'
    break_say = gets.chomp
    break if break_say == 'да'
    end
  end

  def sett
    create_station
    create_station
    create_train
    create_route
    add_railcar_to_train
    add_railcar_to_train
    add_railcar_to_train
  end

  private

  def create_station
    puts 'Введите название станции'
    station = gets.chomp
    @stations << Station.new(station)
  end

  def create_route
    show_station
    puts 'Введите номер начальной станции'
    puts 'Введите номер конечной станции'
    starting_station = gets.chomp.to_i
    terminal_station = gets.chomp.to_i
    @routes << Route.new(@stations[starting_station], @stations[terminal_station])
  end

  def create_train
    puts 'Введите номер, и тип к которому он принадлежит "passenger" или "cargo"'
    id = gets.chomp
    type = gets.chomp.to_sym
    if type == :passenger
      PassengerTrain.new(id)
    elsif type == :cargo
      CargoTrain.new(id)
    else 
      return nil
    end
  end

  def create_train_in_error
    create_train
  rescue
    puts 'Неправильный формат номера'
    retry
  end

  def create_railcar
    type = gets.chomp.to_sym
    if type == :passenger
      puts 'Введите количество мест в вагоне'
      places = gets.chomp.to_i
      @railcars << PassengerRailcar.new(places)
    elsif type == :cargo
      puts 'Введите обьем'
      volume = gets.chomp.to_i
      @railcars << CargoRailcar.new(volume)
    else 
      return nil
    end
  end

  def add_station_to_route
    show_route
    show_station
    puts 'Введите номер уже созданых маршрута и станции'
    number_route = gets.chomp.to_i
    number_station = gets.chomp.to_i
    @routes[number_route].add_station(@stations[number_station])
  end

  def delete_station_to_route
    show_route
    show_station
    puts 'Введите номер уже созданых маршрута и станции'
    number_route = gets.chomp.to_i
    number_station = gets.chomp.to_i
    @routes[number_route].delete_station(@stations[number_station])
  end

  def add_train_to_road
    show_train
    show_route
    puts 'Введите номер уже созданых поезда и маршрута'
    num_train = gets.chomp.to_i
    num_road = gets.chomp.to_i
    @trains[num_train].add_train_to_route(@routes[num_road])
  end

  def move_train_forward
    show_train
    puts 'Введите номер уже сущесствующего поезда'
    num_train = gets.chomp.to_i
    @trains[num_train].move_forward
  end

  def move_train_back
    show_train
    puts 'Введите номер уже сущесствующего поезда'
    num_train = gets.chomp.to_i
    @trains[num_train].move_back
  end

  def add_railcar_to_train
    show_train
    puts 'Введите номер поезда'
    puts 'Введите тип вагона "passenger" или "cargo"'
    num_train = gets.chomp.to_i
    railcar = create_railcar
    if railcar.type == :cargo
      @trains[num_train].add_cargo_railcar(railcar)
    elsif railcar.type == :passenger
        @trains[num_train].add_passenger_railcar(railcar)
    else
      return nil
    end
  end

  def delete_railcar_to_train
    show_train
    puts 'Введите номер поезда'
    num_train = gets.chomp.to_i
    @trains[num_train].delete_railcar(@trains[num_train].railcar.last)
  end

  def show_station
    @stations.each_with_index do |station, num|
      puts "#{station.name} #{num}"
    end
  end

  def show_route
    @routes.each_with_index do |route, num|
      puts "#{route} #{num}"
    end
  end

  def show_train
    @trains.each_with_index do |train, num|
      puts "#{train.number} #{num}"
    end
  end

  def show_train_in_station
    num = -1
    show_station
    puts 'Введите номер станции'
    num_station = gets.chomp.to_i
    @stations[num_station].show_train do |train|
      train.each { |train| puts "#{train.number} #{num += 1}" }
    end
  end

  def show_railcar_in_train
    num = -1
    show_train_in_station
    puts 'Введите индекс поезда'
    num_train = gets.chomp.to_i
    @trains[num_train].show_railcar do |railcar|
      railcar.each { |railcar| puts "#{railcar.type} #{num += 1}" }
    end
  end

  def take_place_or_volume
    show_railcar
    puts 'Введите тип, индекс вагона, поезда и станции'
    type = gets.chomp.to_sym
    num_railcar = gets.chomp.to_i
    num_train = gets.chomp.to_i
    num_station = gets.chomp.to_i
    if type == :cargo
      vol = gets.chomp.to_i
      @station[num_station].show_train do |train|
        train[num_train].railcar[num_railcar].take_the_volume[vol]
      end
    elsif type == :passenger
      @station[num_station].show_train do |train|
        train[num_train].railcar[num_railcar].take_the_place
      end
    else
      return nil
    end
  end  
end
