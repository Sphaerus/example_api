# frozen_string_literal: true

module Api
  class InternalController < ApplicationController
    before_action :authorize_request

    def authorize_request
      @current_user ||= Flow::Api::AuthorizeRequest.new(headers: request.headers).call
      render json: { error: t('errors.token_incorrect') }, status: :unauthorized unless @current_user
    end

    private

    attr_reader :current_user
  end
end
