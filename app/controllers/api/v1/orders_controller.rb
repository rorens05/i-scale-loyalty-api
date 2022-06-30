class Api::V1::OrdersController < Api::V1::ApiController 

  def create
    @order = Order.new(order_params)
    @order.order_items.build(order_items_params[:items])
    if @order.save
      # render json: @order, include: :order_items, status: :created
      render json:  { subtotal: @order.sub_total,
                      discount: @order.discount,
                      points: @order.points,
                      message: "Thank you, GuestFirstName, GuestLastName!" }, 
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
      :transaction_id, 
    )
  end

  def order_items_params 
    params.permit(items: [
        :sku, 
        :price, 
        :quantity 
      ]
    )
  end
end
