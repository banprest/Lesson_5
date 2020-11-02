class Route
  include InstanceCounter
  attr_reader :route, :starting_station, :terminal_station

  def initialize(starting_station,terminal_station)
    @starting_station = starting_station
    @terminal_station = terminal_station
    @route = [@starting_station, @terminal_station]
    register_instance 
  end

  def add_station(station)
    @route.insert(1, station)
  end

  def delete_station(station)
    @route.delete(station)
  end
end