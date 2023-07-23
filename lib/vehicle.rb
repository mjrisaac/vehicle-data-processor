# frozen_string_literal: true

class Vehicle
  attr_reader :vrn, :make, :colour

  def initialize(vrn:, make:, colour:)
    @vrn = validate_vrn(vrn)
    @make = validate_make(make)
    @colour = validate_colour(colour)
  end

  private

  def validate_vrn(vrn)
    vrn.match(/(^[A-Z]{2}\d{2} ?[A-Z]{3}$)/i)
  end

  def validate_make(make)
    make.match(/(^BMW|AUDI|VW|MERCEDES$)/i)
  end

  def validate_colour(colour)
    colour.match(/(^WHITE|BLACK|RED|BLUE$)/i)
  end
end
