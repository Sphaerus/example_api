# frozen_string_literal: true

class PanelProvider < ApplicationRecord
  validates :code, presence: true, uniqueness: true

  CALCULATORS = {
    'times_a'    => PriceCalculator::LetterNumber,
    '10_arrays'  => PriceCalculator::ArrayNumber,
    'times_html' => PriceCalculator::NodesNumber
  }.freeze
  private_constant :CALCULATORS

  def set_calculator_class
    CALCULATORS[code]
  end
end
