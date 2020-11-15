# frozen_string_literal: true

class PassengerTrain < Train
  def add_passenger_railcar(railcar)
    add_railcar(railcar) if its_passenger_train?(railcar)
  end
end
