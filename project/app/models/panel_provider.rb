# frozen_string_literal: true

class PanelProvider < ApplicationRecord
  validates :code, presence: true, uniqueness: true
end
