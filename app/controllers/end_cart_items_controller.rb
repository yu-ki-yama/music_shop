class EndCartItemsController < ApplicationController
  include DataFormat

  def index
    @tax = 108
    cart_items = CartItem.where(end_user_id: current_end_user[:id])
    @carts = cart_items_format_array(cart_items)
    @is_able_purchase_list = stock_check_list(cart_items)


  end

  def update
  	carts = CartItem.where(end_user_id: current_end_user[:id])
    carts.each do |cart|
      if params[cart['id'].to_s] == "0"
        cart.destroy
      elsif cart['purchase_quantity'] != params[cart['id'].to_s]
        cart['purchase_quantity'] = params[cart['id'].to_s]
        cart.save
      end
    end

    @is_able_purchase_list = stock_check_list(CartItem.where(end_user_id: current_end_user[:id]))
    if is_sale(@is_able_purchase_list)
      redirect_to end_purchases_path
    else
      redirect_to end_cart_items_path
    end

  end

  def destroy
  	cart = CartItem.find(params["id"].to_i)
  	cart.destroy
  	redirect_to end_cart_items_path
  end

  def add
    cart = CartItem.new
    cart['item_id'] = params['item_id']
    cart['end_user_id'] = current_end_user['id']
    cart['purchase_quantity'] = params['purchase_quantity']
  	cart.save
    redirect_to end_item_path(params['item_id'])
  end

end
