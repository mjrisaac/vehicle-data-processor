# frozen_string_literal: true

RSpec.describe Csv do
  before(:all) { Dir.mkdir('spec/tmp') unless Dir.exist?('spec/tmp') }
  after(:all) { FileUtils.remove_dir('spec/tmp') if Dir.exist?('spec/tmp') }

  it 'raises an MissingCSV exception when CSV does not exist' do
    directory = 'spec/tmp'
    non_existent_csv = 'non_existent_csv.csv'

    expected_error_detail = "CSV file 'vehicles.csv' not found in 'vehicle_data' folder"

    expect { Csv.csv_present_with_contents(directory:, file_name: non_existent_csv) }.to raise_error(MissingCSV, expected_error_detail)
  end

  it 'raises a EmptyCSV exception when CSV has no contents' do
    directory = 'spec/fixtures'
    empty_csv = 'vehicles.csv'

    expected_error_detail = "CSV file 'vehicles.csv' cannot be empty"

    expect { Csv.csv_present_with_contents(directory:, file_name: empty_csv) }.to raise_error(EmptyCSV, expected_error_detail)
  end

  it 'creates a CSV with contents' do
    directory = 'spec/tmp'
    file_name = 'created_csv.csv'
    headers = %w[header1 header2]
    rows = [%w[row1 data], %w[row2 data]]

    Csv.create_csv(directory:, file_name:, headers:, rows:)

    expect(File.exist?('spec/tmp/created_csv.csv')).to be true
    expect(File.empty?('spec/tmp/created_csv.csv')).to_not be true
  end
end
