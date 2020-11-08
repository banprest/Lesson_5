class CargoRailcar < Railcar
attr_reader :type, :free_volume, :not_free_volume, :volume
  def initialize(volume)
    @volume = volume
    @type = :cargo
    @free_volume = volume
    @not_free_volume = 0
    validate!
  end

  def take_the_volume(vol)
    @free_volume -= vol if @free_volume > 0
    @not_free_volume += vol if @not_free_volume < @volume 
  end

  private

  def validate!
    raise 'Введите положительное число' if volume < 0
  end
end