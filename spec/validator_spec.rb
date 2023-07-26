# frozen_string_literal: true

require_relative '../lib/validator'

RSpec.describe Validator do
  it 'returns a captured pattern when VRN argument is valid' do
    expect(Validator.new.validate_vrn('cE11baz')).to eq('cE11baz')
    expect(Validator.new.validate_vrn('Ln54 coP')).to eq('Ln54 coP')
  end

  it 'returns a captured pattern when Make argument is valid' do
    expect(Validator.new.validate_make('MerCEDeS')).to eq('MerCEDeS')
    expect(Validator.new.validate_make('auDI')).to eq('auDI')
  end

  it 'returns a captured pattern when Colour argument is valid' do
    expect(Validator.new.validate_colour('blAcK')).to eq('blAcK')
    expect(Validator.new.validate_colour('rED')).to eq('rED')
  end

  it 'returns a captured pattern when Date of Manufacture argument is valid' do
    expect(Validator.new.validate_date_of_manufacture('17/08/1978')).to eq('17/08/1978')
    expect(Validator.new.validate_date_of_manufacture('09-03-1933')).to eq('09-03-1933')
    expect(Validator.new.validate_date_of_manufacture('1-2-2002')).to eq('1-2-2002')
  end

  it 'returns nil when VRN argument is invalid' do
    expect(Validator.new.validate_vrn('cE11bazX')).to eq(nil)
    expect(Validator.new.validate_vrn(' Ln54 coP')).to eq(nil)
  end

  it 'returns nil when Make argument is invalid' do
    expect(Validator.new.validate_make(' MerCEDeS')).to eq(nil)
    expect(Validator.new.validate_make('Ford')).to eq(nil)
  end

  it 'returns nil when Colour argument is invalid' do
    expect(Validator.new.validate_colour(' blAcK')).to eq(nil)
    expect(Validator.new.validate_colour('brown')).to eq(nil)
  end

  it 'returns nil when Date of Manufacture argument is invalid' do
    expect(Validator.new.validate_date_of_manufacture('04/12/67')).to eq(nil)
    expect(Validator.new.validate_date_of_manufacture('0-2-2002')).to eq(nil)
    expect(Validator.new.validate_date_of_manufacture('31/12/1899')).to eq(nil)
    expect(Validator.new.validate_date_of_manufacture('1/7/3000')).to eq(nil)
  end
end
