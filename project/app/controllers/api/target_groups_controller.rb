# frozen_string_literal: true

module Api
  class TargetGroupsController < ApplicationController
    def target_groups
      target_groups = Flow::Api::Internal::GetTargetGroups.new(country_code: params[:country_code]).call
      render json: target_groups, each_serializer: TargetGroupSerializer
    end
  end
end
