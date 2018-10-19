# frozen_string_literal: true

class Location < ApplicationRecord
  validates :name, presence: true
  validates :external_id, presence: true, uniqueness: true
  validates :secret_code, presence: true
end
