class Api::V1::OrdersController < Api::V1::ApiController 

  def create
    render json: { message: 'create order controller' }, status: :ok 
  end

  private

end
