# frozen_string_literal: true

class Station
  include InstanceCounter
  include Accessors
  include Validate

  attr_accessor_with_history :ert
  strong_attr_accessor :erp, String
  attr_reader :name, :trains

  validate :name, :percence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
    register_instance
    validate!
  end

  def add_train(train)
    @trains << train
  end

  def list_of_trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def delete_train(train)
    @trains.delete(train)
  end

  def show_train(&block)
    block.call(@trains)
  end


end
