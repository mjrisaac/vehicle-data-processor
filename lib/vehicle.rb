# frozen_string_literal: true

# Class to create a vehicle object with formatted attributes.
class Vehicle
  attr_reader :vrn, :make, :colour, :date_of_manufacture

  # @param vrn [String] vehicle registration number.
  # @param make [String] brand of the vehicle.
  # @param colour [String] colour of the vehicle.
  # @param date_of_manufacture [String] the date the
  #   vehicle was produced.
  # @return Vehicle object.
  def initialize(vrn:, make:, colour:, date_of_manufacture:)
    self.vrn = vrn
    self.make = make
    self.colour = colour
    self.date_of_manufacture = date_of_manufacture
  end

  # Setter method to format VRN to "LLDD LLL".
  # @param vrn [String] VRN to be formatted.
  # @return @vrn [String] formatted VRN.
  def vrn=(vrn)
    @vrn = if vrn.length == 7
             vrn.upcase.insert(4, ' ')
           else
             vrn.upcase
           end
  end

  # Setter method to upcase or capitalise make.
  # @param make [String] make to be formatted.
  # @return @make [String] formatted make.
  def make=(make)
    @make = if make.match?(/^BMW|VW/i)
              make.upcase
            else
              make.capitalize
            end
  end

  # Setter method to capitalise colour.
  # @param colour [String] colour to be formatted.
  # @return @colour [String] formatted colour.
  def colour=(colour)
    @colour = colour.capitalize
  end

  # Setter method to format date of manufacture to
  #   "Day, DD Month YYYY" e.g. "Fri, 15 April 1994"
  # @param date_of_manufacture [String] date to be
  #   formatted.
  # @return @date_of_manufacture [String] formatted
  #   colour.
  def date_of_manufacture=(date_of_manufacture)
    @date_of_manufacture = Date.parse(date_of_manufacture).strftime('%a, %d %B %Y')
  end

  # Returns instance variables of Vehicle class as
  #   an Array.
  # @return [Array] of instance variables.
  def to_a
    [@vrn, @make, @colour, @date_of_manufacture]
  end
end
