class Validator
  def initialize(vehicle_data:)
    @vehicle_data = vehicle_data
  end

  def validate_data
    if @vehicle_data.is_a?(CSV::Table)
      @vehicle_data.each do |vehicle|
        validate_vehicle(vehicle:)
      end
    else
      raise ArgumentError, 'Vehicle data is not valid CSV::Table object'
    end
  end

  private

  def validate_vehicle(vehicle:)
    # binding.pry
    valid_vrn?(vrn: vehicle['vrn'])
  end

  def valid_vrn?(vrn:)
    vrn.match?(/^([A-Z]{2}\d{2}\s?[A-Z]{3})$/i)
  end
end
