# frozen_string_literal: true

# Class to create a vehicle object with formatted attributes
class Vehicle
  attr_reader :vrn, :make, :colour, :date_of_manufacture

  def initialize(vrn:, make:, colour:, date_of_manufacture:)
    self.vrn = vrn
    self.make = make
    self.colour = colour
    self.date_of_manufacture = date_of_manufacture
  end

  def vrn=(vrn)
    @vrn = if vrn.length == 7
             vrn.upcase.insert(4, ' ')
           else
             vrn.upcase
           end
  end

  def make=(make)
    @make = if make.match?(/^BMW|VW/i)
              make.upcase
            else
              make.capitalize
            end
  end

  def colour=(colour)
    @colour = colour.capitalize
  end

  def date_of_manufacture=(date_of_manufacture)
    @date_of_manufacture = Date.parse(date_of_manufacture).strftime('%a, %d %B %Y')
  end

  def to_a
    [@vrn, @make, @colour, @date_of_manufacture]
  end
end
