# frozen_string_literal: true

require 'csv'
require 'pry'

binding.pry

data_table = CSV.parse(File.read('vehicle-data/vehicles.csv'), headers: true)
