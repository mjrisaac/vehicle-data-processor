# frozen_string_literal: true

require_relative '../lib/vehicle'

RSpec.describe Vehicle do
  it 'formats keyword arguments on initialisation' do
    vehicle = Vehicle.new(vrn: 'br54slp', make: 'vw', colour: 'WhitE', date_of_manufacture: '01/07/2000')

    expect(vehicle.vrn).to eq('BR54 SLP')
    expect(vehicle.make).to eq('VW')
    expect(vehicle.colour).to eq('White')
    expect(vehicle.date_of_manufacture).to eq('Sat, 01 July 2000')
  end

  it 'returns instance variables as an Array of Strings when .to_a is called' do
    vehicle = Vehicle.new(vrn: 'Ab12 XyZ', make: 'auDI', colour: 'REd', date_of_manufacture: '24/03/2006').to_a
    expect(vehicle).to eq(['AB12 XYZ', 'Audi', 'Red', 'Fri, 24 March 2006'])
  end
end
