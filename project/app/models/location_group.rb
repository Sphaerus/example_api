# frozen_string_literal: true

class LocationGroup < ApplicationRecord
  belongs_to :country
  belongs_to :panel_provider
  has_many   :locations

  scope :with_provider, ->(provider_id) { where(panel_provider_id: provider_id) }
end
