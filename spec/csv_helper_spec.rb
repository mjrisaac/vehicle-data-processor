# frozen_string_literal: true

require 'logger'
require_relative '../lib/csv_helper'

LOG = Logger.new($stdout)

RSpec.describe Csv do
  before(:all) { Dir.mkdir('spec/tmp') unless Dir.exist?('spec/tmp') }
  after(:all) { FileUtils.remove_dir('spec/tmp') if Dir.exist?('spec/tmp') }

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
