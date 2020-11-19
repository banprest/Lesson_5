# frozen_string_literal: true

class CargoRailcar < Railcar
  include Validate
  attr_reader :type, :free_volume, :not_free_volume, :volume

  validate :volume, :positive

  def initialize(volume)
    @volume = volume
    @type = :cargo
    @free_volume = volume
    @not_free_volume = 0
    validate!
  end

  def take_the_volume(vol)
    @free_volume -= vol if @free_volume.positive?
    @not_free_volume += vol if @not_free_volume < @volume
  end
end
