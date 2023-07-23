# frozen_string_literal: true

require 'csv'
require 'pry'
require_relative '../lib/errors'
require_relative '../lib/vehicle'

VEHICLES_CSV = 'vehicle-data/vehicles.csv'

if File.exist?(VEHICLES_CSV)
  CSV.foreach(VEHICLES_CSV, headers: true) do |row|
    vehicle = Vehicle.new(vrn: row['vrn'], make: row['make'], colour: row['colour'])
  end
else
  raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle-data' folder"
end
