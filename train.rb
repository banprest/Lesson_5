# frozen_string_literal: true

class Train
  include NameManufacturingCompany
  include InstanceCounter
  include Validate
  attr_accessor :speed

  attr_reader :railcar, :type, :current_station, :number

  NUMBER_FORMAT = /^[а-я0-9]{3}-*{1}[а-я0-9]{2}$/i.freeze

  validate :number, :percence
  validate :number, :format, NUMBER_FORMAT
  

  @@trains = {}

  def self.find(num)
    @@trains[num]
  end

  def initialize(number)
    @number = number
    @railcar = []
    @speed = 0
    @@trains[number] = self
    register_instance
    validate!
  end

  def stop
    self.speed = 0
  end

  def add_train_to_route(way)
    @way = way
    @current_station = way.starting_station
    @current_station.add_train(self)
  end

  def move_forward
    @current_station.delete_train(self)
    @current_station = next_station
    @current_station.add_train(self)
  end

  def move_back
    @current_station.delete_train(self)
    @current_station = previous_station
    @current_station.add_train(self)
  end

  def next_station
    return if @current_station == @way.terminal_station

    @way.route[@way.route.index(current_station) + 1]
  end

  def previous_station
    return if @current_station == @way.starting_station

    @way.route[@way.route.index(current_station) - 1]
  end

  def delete_railcar(railcar)
    @railcar.delete(railcar)
  end

  def its_cargo_train?(railcar)
    railcar.type == :cargo
  end

  def its_passenger_train?(railcar)
    railcar.type == :passenger
  end

  def show_railcar(&block)
    block.call(@railcar)
  end

  protected


  def add_railcar(railcar)
    @railcar << railcar
  end
end
