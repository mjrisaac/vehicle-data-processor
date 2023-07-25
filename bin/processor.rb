# frozen_string_literal: true

require 'csv'
require 'logger'
require 'pry'
require_relative '../lib/csv_helper'
require_relative '../lib/errors'
require_relative '../lib/validation'
require_relative '../lib/vehicle'

VEHICLES_CSV = 'vehicle_data/vehicles.csv'
VRN = 'vrn'
MAKE = 'make'
COLOUR = 'colour'
DATE_OF_MANUFACTURE = 'dateOfManufacture'
VEHICLE_ATTRIBUTES = %w[vrn make colour dateOfManufacture].freeze
CSV_TO_CREATE = 'vehicle_data/valid_vehicles.csv'
HEADERS = ['VRN', 'Make', 'Colour', 'Date of Manufacture'].freeze
LOG = Logger.new($stdout)
LOG.formatter = proc { |severity, datetime, _progname, msg| "[#{datetime}  #{severity}  VehiclesProcessor] -- #{msg}\n" }

module VehicleDataProcessor
  raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle_data' folder" unless File.exist?(VEHICLES_CSV)

  raise EmptyCSV, "CSV file 'vehicles.csv' cannot be empty" if File.empty?(VEHICLES_CSV)

  valid_vehicles = []
  invalid_vehicles = []

  CSV.foreach(VEHICLES_CSV, headers: true) do |row|
    vehicle = {}

    vehicle[VRN] = Validation.validate_vrn(row[VRN])
    vehicle[MAKE] = Validation.validate_make(row[MAKE])
    vehicle[COLOUR] = Validation.validate_colour(row[COLOUR])
    vehicle[DATE_OF_MANUFACTURE] = Validation.validate_date_of_manufacture(row[DATE_OF_MANUFACTURE])

    invalid_attributes = []

    VEHICLE_ATTRIBUTES.each do |attribute|
      invalid_attributes << attribute if vehicle[attribute].nil?
    end

    if invalid_attributes.empty?
      valid_vehicle = Vehicle.new(vrn: vehicle[VRN], make: vehicle[MAKE], colour: vehicle[COLOUR], date_of_manufacture: vehicle[DATE_OF_MANUFACTURE])

      valid_vehicles << valid_vehicle.to_a
    else
      invalid_vehicles << invalid_attributes
    end
  end

  Csv.create_csv(file_name: CSV_TO_CREATE, headers: HEADERS, rows: valid_vehicles)

  total_vehicles = valid_vehicles.count + invalid_vehicles.count
  total_valid_vehicles = valid_vehicles.count
  total_invalid_vehicles = invalid_vehicles.count

  LOG.info("        TOTAL VEHICLES: #{total_vehicles}")

  if total_invalid_vehicles.positive?
    totals = invalid_vehicles.tally
    sorted_totals = totals.sort.to_h

    sorted_totals.each { |k, v| LOG.info("  Vehicles with invalid #{k}: #{v}") }

    LOG.info("TOTAL INVALID VEHICLES: #{total_invalid_vehicles}")
  end

  LOG.info("  TOTAL VALID VEHICLES: #{total_valid_vehicles}")
end
