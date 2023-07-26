# frozen_string_literal: true

# Namespace for validation helper method.
module Validation
  VEHICLE_ATTRIBUTES = %w[vrn make colour dateOfManufacture].freeze

  # Validates each attribute of vehicle data by calling
  #   the Validator class with the appropriate
  #   validation method.
  # @param row [Hash] the vehicle data to be
  #   validated.
  # @return [Hash] validated vehicle data.
  def self.validate_vehicle_data_in_row(row:)
    VEHICLE_ATTRIBUTES.each_with_object({}) do |attribute, vehicle|
      vehicle[attribute] = if attribute == 'dateOfManufacture'
                             Validator.new.validate_date_of_manufacture(row[attribute])
                           else
                             Validator.new.send("validate_#{attribute}", row[attribute])
                           end
    end
  end
end
