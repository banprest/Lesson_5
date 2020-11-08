class PassengerRailcar < Railcar
attr_reader :type, :free_places, :not_free_places, :places
  
  def initialize(places)
    @type = :passenger
    @free_places = places
    @not_free_places = 0
    @places = places
    validate!
  end

  def take_the_place
    @free_places -= 1 if @free_places > 0
    @not_free_places += 1 if @not_free_places < @places
  end

  private

  def validate!
    raise 'Введите положительное число' if places < 0
  end
end