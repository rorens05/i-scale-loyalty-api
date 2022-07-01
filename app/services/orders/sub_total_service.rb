# frozen_string_literal: true

module Orders
  ##
  # This service calculate sub total for an order
  # Sub total is items total - discount
  class SubTotalService < ApplicationService
    def initialize(order)
      @order = order
      super()
    end

    def call
      @order.item_total - @order.discount
    end
  end
end
