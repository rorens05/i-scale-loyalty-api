# frozen_string_literal: true

module Api
  module V1
    class OrdersController < Api::V1::ApiController
      def create
        @order = Order.new(order_params)
        @order.order_items.build(order_items_params[:items])
        if @order.save
          render json: { subtotal: @order.sub_total,
                         discount: @order.discount,
                         points: @order.points,
                         message: 'Thank you, GuestFirstName, GuestLastName!' },
                 status: :created
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
        params.permit(items: %i[
                        sku
                        price
                        quantity
                      ])
      end
    end
  end
end
