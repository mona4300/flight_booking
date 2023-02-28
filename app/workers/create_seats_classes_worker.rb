class CreateSeatsClassesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(flight_id)
    flight = Flight.find(flight_id)
    flight_manager = FlightService::Manager.new(flight:)
    flight_manager.prepare
  end
end
