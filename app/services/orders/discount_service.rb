# frozen_string_literal: true

module Orders
  ##
  # This service calculate discount for an order
  # Discount is calculated as follows:
  # - If the order contains a product with SKU "DISCOUNTED_SKU", the discount is 2
  # - If the order total is greater than MINIMUM_AMOUNT_FOR_DISCOUNT, the discount is the order * DISCOUNT_RATE
  # - Only one discount can be applied, so the discount is the greater of the two
  # - Otherwise, the discount is 0
  # Recommendation for improvement
  # - store the list discount rate with the minimum amount for discount in the database
  # - store the list of SKU that are discounted in the database
  class DiscountService < ApplicationService
    MINIMUM_AMOUNT_FOR_DISCOUNT = 10
    DISCOUNT_RATE = 0.2

    DISCOUNTED_SKU = 'CCC'
    DISCOUNTED_SKU_AMOUNT = 2

    def initialize(order)
      @order = order
      super()
    end

    def call
      (sku_discount > percentage_discount ? sku_discount : percentage_discount)
    end

    private

    def percentage_discount
      discounted_by_amount? ? @order.item_total * DISCOUNT_RATE : 0
    end

    def sku_discount
      discounted_by_sku? ? DISCOUNTED_SKU_AMOUNT : 0
    end

    def discounted_by_sku?
      @order.order_items.any? { |item| item.sku == DISCOUNTED_SKU }
    end

    def discounted_by_amount?
      @order.item_total > MINIMUM_AMOUNT_FOR_DISCOUNT
    end
  end
end
