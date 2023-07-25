# frozen_string_literal: true

# methods for validation
module Validation
  EARLIEST_VALID_DATE = Date.parse('01/01/1900')
  CURRENT_DATE = Date.today

  def self.validate_vrn(vrn)
    raise VehicleAttributeIsNotString, 'Invalid vrn' unless vrn.is_a?(String)

    vrn.match(/(^[A-Z]{2}\d{2} ?[A-Z]{3}$)/i)
    ::Regexp.last_match(1)
  end

  def self.validate_make(make)
    raise VehicleAttributeIsNotString, 'Invalid make' unless make.is_a?(String)

    make.match(/(^BMW|AUDI|VW|MERCEDES$)/i)
    ::Regexp.last_match(1)
  end

  def self.validate_colour(colour)
    raise VehicleAttributeIsNotString, 'Invalid colour' unless colour.is_a?(String)

    colour.match(/(^WHITE|BLACK|RED|BLUE$)/i)
    ::Regexp.last_match(1)
  end

  def self.validate_date_of_manufacture(date_of_manufacture)
    raise VehicleAttributeIsNotString, 'Invalid date of manufacture' unless date_of_manufacture.is_a?(String)

    begin
      date = Date.parse(date_of_manufacture)

      date >= EARLIEST_VALID_DATE && date <= CURRENT_DATE ? date_of_manufacture : nil
    rescue Date::Error
      nil
    end
  end
end
