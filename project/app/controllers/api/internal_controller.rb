# frozen_string_literal: true

module Api
  class InternalController < ApplicationController
    before_action :authorize_request

    def authorize_request
      @current_user ||= Flow::Api::Internal::AuthorizeRequest.new(auth_token: request.headers['auth_token']).call
      render json: { error: t('errors.token_incorrect') } unless @current_user
    end

    private

    attr_reader :current_user
  end
end
