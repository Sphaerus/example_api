# frozen_string_literal: true

class Country < ApplicationRecord
  belongs_to :panel_provider, required: false
  has_and_belongs_to_many :target_groups
  has_many :location_groups

  validates :code, presence: true, uniqueness: true
  validate :correct_target_groups

  private

  def correct_target_groups
    errors.add(:target_groups, 'country can only have root target groups') if target_groups.any?(&:parent)
  end
end
