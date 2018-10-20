# frozen_string_literal: true

module Api
  module Internal
    class TargetGroupsController < InternalController
      def target_groups
        groups = Flow::Api::Internal::GetTargetGroups.new(country_code: params[:country_code]).call
        render json: groups, each_serializer: TargetGroupSerializer
      end
    end
  end
end
