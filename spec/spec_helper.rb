# frozen_string_literal: true

require 'csv'
require 'logger'
require 'pry'
require_relative '../lib/csv_helper'
require_relative '../lib/errors'
require_relative '../lib/validation_helper'
require_relative '../lib/validator'
require_relative '../lib/vehicle'

LOG = Logger.new($stdout)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
