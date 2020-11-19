# frozen_string_literal: true

class PassengerRailcar < Railcar
  include Validate
  attr_reader :type, :free_places, :not_free_places, :places

  validate :free_places, :positive

  def initialize(places)
    @type = :passenger
    @free_places = places
    @not_free_places = 0
    @places = places
    validate!
  end

  def take_the_place
    @free_places -= 1 if @free_places.positive?
    @not_free_places += 1 if @not_free_places < @places
  end
end
