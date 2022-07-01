# frozen_string_literal: true

module Api
  module V1
    ##
    # This controller handles all actions related to orders
    class OrdersController < Api::V1::ApiController
      def create
        @order = Order.new(order_params)
        @order.order_items.build(order_items_params[:items])
        @order = Orders::OrderCalculatorService.call(order: @order, discount_service: Orders::DiscountService,
                                                     points_service: Orders::PointsService,
                                                     sub_total_service: Orders::SubTotalService)
        if @order.save
          render json: success_response(@order), status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      private

      def order_params
        params.permit(
          :timestamp,
          :store_id,
          :guest_id,
          :transaction_id
        )
      end

      def order_items_params
        params.permit(items: %i[sku price quantity])
      end

      def success_response(order)
        {
          subtotal: order.sub_total,
          discount: order.discount,
          points: order.points,
          message: "Thank you, #{order.guest.name}!"
        }
      end
    end
  end
end
