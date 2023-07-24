# frozen_string_literal: true

require 'csv'
require 'logger'
require 'pry'
require_relative '../lib/csv_helper'
require_relative '../lib/errors'
require_relative '../lib/formatting_helper'
require_relative '../lib/vehicle'

VEHICLES_CSV = 'vehicle-data/vehicles.csv'
VEHICLE_ATTRIBUTES = %w[vrn make colour dateOfManufacture].freeze
CSV_TO_CREATE = 'vehicle-data/valid_vehicles.csv'
HEADERS = ['VRN', 'Make', 'Colour', 'Date of Manufacture'].freeze
LOG = Logger.new($stdout)
LOG.formatter = proc { |severity, datetime, _progname, msg| "[#{datetime}  #{severity}  VehiclesProcessor] -- #{msg}\n" }

module VehicleDataProcessor
  raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle-data' folder" unless File.exist?(VEHICLES_CSV)

  valid_vehicles = []
  invalid_vehicles = []

  CSV.foreach(VEHICLES_CSV, headers: true) do |row|
    vehicle = Vehicle.new(vrn: row['vrn'], make: row['make'], colour: row['colour'], date_of_manufacture: row['dateOfManufacture']).to_h

    invalid_attributes = []

    VEHICLE_ATTRIBUTES.each do |attribute|
      invalid_attributes << attribute if vehicle[attribute].nil?
    end

    if invalid_attributes.empty?
      formatted_vehicle_data = vehicle.map do |key, value|
        case key
        when 'vrn'
          Formatting.format_vrn(value)
        when 'make'
          Formatting.format_make(value)
        when 'colour'
          Formatting.format_colour(value)
        else
          Formatting.format_date_of_manufacture(value)
        end
      end

      valid_vehicles << formatted_vehicle_data
    else
      invalid_vehicles << invalid_attributes
    end
  end

  Csv.create_csv(file_name: CSV_TO_CREATE, headers: HEADERS, rows: valid_vehicles)

  total_vehicles = valid_vehicles.count + invalid_vehicles.count
  total_valid_vehicles = valid_vehicles.count
  total_invalid_vehicles = invalid_vehicles.count

  LOG.info("        TOTAL VEHICLES: #{total_vehicles}")
  LOG.info("  TOTAL VALID VEHICLES: #{total_valid_vehicles}")

  if total_invalid_vehicles.positive?
    totals = invalid_vehicles.tally
    sorted_totals = totals.sort.to_h

    sorted_totals.each { |k, v| LOG.info("  Vehicles with invalid #{k}: #{v}") }

    LOG.info("TOTAL INVALID VEHICLES: #{total_invalid_vehicles}")
  end
end
