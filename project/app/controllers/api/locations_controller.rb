# frozen_string_literal: true

module Api
  class LocationsController < ApplicationController
    def locations
      locations = Flow::Api::Internal::GetLocations.new(country_code: params[:country_code]).call
      render json: locations, each_serializer: LocationSerializer
    end
  end
end
