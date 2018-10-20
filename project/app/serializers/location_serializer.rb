# frozen_string_literal: true

class LocationSerializer < ActiveModel::Serializer
  attributes :name, :external_id, :location_group_id, :secret_code
end
