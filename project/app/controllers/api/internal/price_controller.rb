# frozen_string_literal: true

module Api
  module Internal
    class PriceController < InternalController
      def price
        price = Flow::Api::Internal::GetPrice.new(
          country_code:    params[:country_code],
          target_group_id: params[:target_group_id],
          locations:       params[:locations]
        ).call
        render json: { price: price }
      end
    end
  end
end
