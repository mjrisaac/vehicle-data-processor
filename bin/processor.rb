# frozen_string_literal: true

require 'csv'
require 'logger'
require 'pry'
require_relative '../lib/csv_helper'
require_relative '../lib/errors'
require_relative '../lib/validation_helper'
require_relative '../lib/validator'
require_relative '../lib/vehicle'

VEHICLES_CSV = 'vehicle_data/vehicles.csv'
VRN = 'vrn'
MAKE = 'make'
COLOUR = 'colour'
DATE_OF_MANUFACTURE = 'dateOfManufacture'
CREATED_CSV_DESTINATION = 'vehicle_data'
CREATED_CSV_NAME = 'valid_vehicles.csv'
HEADERS = ['VRN', 'Make', 'Colour', 'Date of Manufacture'].freeze
LOG = Logger.new($stdout)
LOG.formatter = proc { |severity, datetime, _progname, msg| "[#{datetime}  #{severity}  VehiclesProcessor] -- #{msg}\n" }

# Namespace for the vehicle data processor.
module VehicleDataProcessor
  raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle_data' folder" unless File.exist?(VEHICLES_CSV)

  raise EmptyCSV, "CSV file 'vehicles.csv' cannot be empty" if File.empty?(VEHICLES_CSV)

  valid_vehicles = []
  invalid_vehicles = []

  CSV.foreach(VEHICLES_CSV, headers: true) do |row|
    # Validates each attribute of the vehicle in the CSV row to create Hash of validated data.
    validated_vehicle_data = Validation.validate_vehicle_data_in_row(row: row.to_h)

    # Creates Array of invalid attributes from validated_vehicle_data Hash.
    invalid_vehicle_attributes = validated_vehicle_data.select { |_key, value| value.nil? }.keys

    # Valid vehicle: creates vehicle object from original CSV row data and adds (as an Array) to valid_vehicles Array.
    # Invalid vehicle: adds invalid_vehicle_attributes to invalid_vehicles Array.
    if invalid_vehicle_attributes.empty?
      valid_vehicle = Vehicle.new(vrn: row[VRN],
                                  make: row[MAKE],
                                  colour: row[COLOUR],
                                  date_of_manufacture: row[DATE_OF_MANUFACTURE]).to_a

      valid_vehicles << valid_vehicle
    else
      invalid_vehicles << invalid_vehicle_attributes
    end
  end

  # Creates CSV for valid vehicles.
  Csv.create_csv(directory: CREATED_CSV_DESTINATION, file_name: CREATED_CSV_NAME, headers: HEADERS, rows: valid_vehicles)

  total_valid_vehicles = valid_vehicles.count
  total_invalid_vehicles = invalid_vehicles.count

  LOG.info(' Processing report:')
  LOG.info("         TOTAL VEHICLES: #{total_valid_vehicles + total_invalid_vehicles}")

  # Logs totals for reason(s) each vehicle is invalid.
  if total_invalid_vehicles.positive?
    totals = invalid_vehicles.tally
    sorted_totals = totals.sort.to_h

    sorted_totals.each { |key, value| LOG.info("   Vehicles with invalid #{key}: #{value}") }
  end

  LOG.info(" TOTAL INVALID VEHICLES: #{total_invalid_vehicles}")
  LOG.info("   TOTAL VALID VEHICLES: #{total_valid_vehicles}")
end
