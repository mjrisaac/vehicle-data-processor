# frozen_string_literal: true

module Formatting
  MAKES_TO_UPCASE = %w[bmw vw].freeze

  def self.format_vrn(vrn)
    if vrn.length == 7
      vrn.upcase.insert(4, ' ')
    else
      vrn.upcase
    end
  end

  def self.format_make(make)
    downcase_make = make.downcase

    if MAKES_TO_UPCASE.include?(downcase_make)
      make.upcase
    else
      make.capitalize
    end
  end

  def self.format_colour(colour)
    downcase_colour = colour.downcase

    downcase_colour.capitalize
  end

  def self.format_date_of_manufacture(date_of_manufacture)
    Date.parse(date_of_manufacture).strftime('%a, %d %B %Y')
  end
end
