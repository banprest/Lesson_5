class Route
  include InstanceCounter
  attr_reader :route, :starting_station, :terminal_station

  def initialize(starting_station,terminal_station)
    @starting_station = starting_station
    @terminal_station = terminal_station
    @route = [@starting_station, @terminal_station]
    register_instance
    validate! 
  end

  def add_station(station)
    @route.insert(1, station)
  end

  def delete_station(station)
    @route.delete(station)
  end

  def valid?
    validate!
    true
  rescue 
    false
  end

  private

  def validate!
    raise 'Таких станций не существует' if starting_station.class && terminal_station.class != Station
    raise 'Начальная и конечная станция должны быть разными' if starting_station == terminal_station
  end 


end