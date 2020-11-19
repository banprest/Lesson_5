# frozen_string_literal: true

class Route
  include InstanceCounter
  include Validate
  attr_reader :route, :starting_station, :terminal_station

  validate :starting_station, :type, Station
  validate :terminal_station, :type, Station

  def initialize(starting_station, terminal_station)
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
end
