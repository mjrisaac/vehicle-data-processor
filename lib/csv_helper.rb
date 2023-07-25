# frozen_string_literal: true

# Namespace for method to create a CSV.
module Csv
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
