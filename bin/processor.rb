# frozen_string_literal: true

require 'csv'
require 'pry'
require_relative '../lib/validator'

data_table = CSV.parse(File.read('vehicle-data/vehicles.csv'), headers: true)

validator = Validator.new(vehicle_data: data_table)

validator.validate_data
