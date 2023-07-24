# frozen_string_literal: true

class Vehicle
  EARLIEST_VALID_DATE = Date.parse('01/01/1900')

  def initialize(vrn:, make:, colour:, date_of_manufacture:)
    self.vrn = vrn
    self.make = make
    self.colour = colour
    self.date_of_manufacture = date_of_manufacture
  end

  def vrn=(vrn)
    vrn.match(/(^[A-Z]{2}\d{2} ?[A-Z]{3}$)/i)
    @vrn = $1
  end

  def make=(make)
    make.match(/(^BMW|AUDI|VW|MERCEDES$)/i)
    @make = $1
  end

  def colour=(colour)
    colour.match(/(^WHITE|BLACK|RED|BLUE$)/i)
    @colour = $1
  end

  def date_of_manufacture=(date_of_manufacture)
    matched_data = date_of_manufacture.match(/(?<date>^0?\d{1,2}[-\/]0?\d{1,2}[-\/]\d{4}$)/)

    valid_date = if matched_data
                   date = Date.parse(matched_data['date']) rescue Date::Error(false)

                   if date >= EARLIEST_VALID_DATE && date <= Date.today
                     true
                   else
                     false
                   end
                 end

    @date_of_manufacture = valid_date ? matched_data['date'] : nil
  end

  def to_h
    { 'vrn' => @vrn, 'make' => @make, 'colour' => @colour, 'dateOfManufacture' => @date_of_manufacture }
  end
end
