class TargetGroup < ApplicationRecord
  belongs_to :panel_provider, required: false
  has_many :target_groups, foreign_key: :parent_id
  belongs_to :parent, class_name: 'TargetGroup', foreign_key: :parent_id, required: false
  has_and_belongs_to_many :countries
end
