class Station
  include InstanceCounter
  attr_reader :name, :trains

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

  def valid?
    validate!
    true
  rescue 
    false
  end

  def show_train(&block)
    block.call(@trains)
  end
  private

  def validate!
    raise 'Название не должно быть пустым' if name.length.zero?
  end
end