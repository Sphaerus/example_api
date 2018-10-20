# frozen_string_literal: true

class TargetGroupSerializer < ActiveModel::Serializer
  attributes :name, :external_id, :parent_id, :secret_code, :panel_provider_id
end
