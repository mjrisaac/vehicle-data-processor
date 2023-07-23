# frozen_string_literal: true

require 'csv'
require 'logger'
require 'pry'
require_relative '../lib/errors'
require_relative '../lib/vehicle'

VEHICLES_CSV = 'vehicle-data/vehicles.csv'
VEHICLE_ATTRIBUTES = %w[vrn make colour]

LOG = Logger.new($stdout)

if File.exist?(VEHICLES_CSV)
  invalid_vrn = 0
  invalid_make = 0
  invalid_colour = 0

  CSV.foreach(VEHICLES_CSV, headers: true) do |row|
    vehicle = Vehicle.new(vrn: row['vrn'], make: row['make'], colour: row['colour'])

    invalid_attributes = []

    VEHICLE_ATTRIBUTES.each do |attr|
      invalid_attributes << attr if vehicle.send(attr).nil?
    end

    if invalid_attributes.empty?
      # Valid
    else
      invalid_attributes.each do |attr|
        if attr == 'vrn'
          invalid_vrn += 1
        elsif attr == 'make'
          invalid_make += 1
        elsif attr == 'colour'
          invalid_colour +=1
        end
      end
    end
  end

  LOG.info("TOTAL INVALID VEHICLES: #{invalid_vrn + invalid_make + invalid_colour}")
  LOG.info("  #{invalid_vrn} vehicles with invalid VRN: must be 'LLDDLLL' or 'LLDD LLL' format. All characters are case insensitive")
  LOG.info("  #{invalid_make} vehicles with invalid MAKE: must be 'BMW', 'AUDI', 'VW' or 'MERCEDES'. All characters are case insensitive")
  LOG.info("  #{invalid_colour} vehicles with invalid COLOUR: must be 'WHITE', 'BLACK', 'RED' or 'BLUE'. All characters are case insensitive")
else
  raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle-data' folder"
end
