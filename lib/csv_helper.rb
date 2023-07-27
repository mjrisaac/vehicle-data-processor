# frozen_string_literal: true

# Namespace for method to create a CSV.
module Csv
  # Checks a CSV file exists and is not empty.
  # @param directory [String] directory where CSV is located.
  # @param file_name [String] name of the CSV file.
  # @raise [MissingCSV] if CSV does not exist.
  # @raise [EmptyCSV] if CSV is empty.
  # @return [nil] if file exists and is not empty.
  def self.csv_present_with_contents(directory:, file_name:)
    file_location = "#{directory}/#{file_name}"

    raise MissingCSV, "CSV file 'vehicles.csv' not found in 'vehicle_data' folder" unless File.exist?(file_location)

    raise EmptyCSV, "CSV file 'vehicles.csv' cannot be empty" if File.empty?(file_location)
  end

  # Creates a CSV.
  # @param directory [String] directory for the CSV to
  #   be created in.
  # @param file_name [String] name for the created CSV.
  # @param headers [Array<String>] headers for CSV data.
  # @param rows [Array<Array<String>>] rows of CSV data.
  # @return [Array<Array<String>>] rows of data returned
  #   by CSV class.
  def self.create_csv(directory:, file_name:, headers:, rows:)
    LOG.info("Creating CSV '#{file_name}' in '#{directory}'...")

    CSV.open("#{directory}/#{file_name}", 'w') do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end
end
