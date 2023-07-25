# frozen_string_literal: true

# Methods to help with CSV handling
module Csv
  def self.create_csv(file_name:, headers:, rows:)
    CSV.open(file_name, 'w') do |csv|
      csv << headers
      rows.each do |row|
        csv << row
      end
    end
  end
end
