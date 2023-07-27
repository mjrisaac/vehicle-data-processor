# frozen_string_literal: true

RSpec.describe Validation do
  it 'returns captured patterns for vehicle attributes when arguments are valid' do
    vehicle_data = { 'vrn' => 'Eg03 wTA', 'make' => 'bmW', 'colour' => 'BLUE', 'dateOfManufacture' => '26-6-2013' }

    expect(Validation.validate_vehicle_data_in_row(row: vehicle_data))
      .to eq({ 'vrn' => 'Eg03 wTA', 'make' => 'bmW', 'colour' => 'BLUE', 'dateOfManufacture' => '26-6-2013' })
  end

  it 'returns nil for vehicle attributes when arguments are invalid' do
    vehicle_data = { 'vrn' => 'S67 lWn', 'make' => 'auDii', 'colour' => ' Red', 'dateOfManufacture' => '01/02/98' }

    expect(Validation.validate_vehicle_data_in_row(row: vehicle_data))
      .to eq({ 'vrn' => nil, 'make' => nil, 'colour' => nil, 'dateOfManufacture' => nil })
  end
end
