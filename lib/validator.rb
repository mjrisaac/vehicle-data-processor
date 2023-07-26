# frozen_string_literal: true

# Class for validating vehicle data.
class Validator
  EARLIEST_VALID_DATE = Date.parse('01/01/1900')
  CURRENT_DATE = Date.today

  # Validates data meets criteria for VRN format.
  #   Criteria: "LLDD LLL" or "LLDDLLL". Space
  #   is optional.
  # @param vrn [String] the data to be validated.
  # @return [String, nil] captured pattern if
  #   data matches regex, nil if no match.
  def validate_vrn(vrn)
    vrn.match(/(^[A-Z]{2}\d{2} ?[A-Z]{3}$)/i)
    ::Regexp.last_match(1)
  end

  # Validates data meets criteria for vehicle make.
  #   Criteria: "BMW", "AUDI", "VW" or "MERCEDES".
  #   Case insensitive.
  # @param make [String] the data to be validated.
  # @return [String, nil] captured pattern if data
  #   matches regex, nil if no match.
  def validate_make(make)
    make.match(/(^BMW$|^AUDI$|^VW$|^MERCEDES$)/i)
    ::Regexp.last_match(1)
  end

  # Validates data meets criteria for vehicle colour.
  #   Criteria: "WHITE", "BLACK", "RED" or "WHITE".
  #   Case insensitive.
  # @param colour [String] the data to be validated.
  # @return [String, nil] captured pattern if data
  #   matches regex, nil if no match.
  def validate_colour(colour)
    colour.match(/(^WHITE$|^BLACK$|^RED$|^BLUE$)/i)
    ::Regexp.last_match(1)
  end

  # Validates data meets criteria for vehicle date of
  #   manufacture. Criteria: DD-MM-YYYY or DD/MM/YYYY.
  #   Leading zero for day and month is optional.
  #   Must be date between 01/01/1900 and current date.
  # @param date_of_manufacture [String] the data to be
  #   validated.
  # @return [String, nil] date passed in if date is
  #   valid, nil if invalid.
  def validate_date_of_manufacture(date_of_manufacture)
    date = Date.parse(date_of_manufacture)

    date >= EARLIEST_VALID_DATE && date <= CURRENT_DATE ? date_of_manufacture : nil
  rescue Date::Error
    nil
  end
end
