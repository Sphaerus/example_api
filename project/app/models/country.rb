# frozen_string_literal: true

class Country < ApplicationRecord
  belongs_to :panel_provider

  validates :code, presence: true, uniqueness: true
  validates :panel_provider, presence: true
end
