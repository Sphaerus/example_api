# frozen_string_literal: true

module Validator
  class GetPriceParams < Base
    validate :location_params_correctness

    def initialize(locations:)
      @locations = locations
    end

    private

    attr_reader :locations

    def location_params_correctness
      return true if locations.is_a?(Array) && locations_have_proper_keys_and_values?
      errors.add(:location_params, 'are invalid')
    end

    def locations_have_proper_keys_and_values?
      locations.all? do |location|
        location.key?(:id) && location.key?(:panel_size) && location.values.all? do |value|
          value.is_a?(Integer)
        end
      end
    end
  end
end
