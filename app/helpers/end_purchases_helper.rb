module EndPurchasesHelper
  def all_price(cart_item_model, tax)
    all_price = 0
    cart_item_model.each do |cart|
      all_price += cart['price'] * cart['purchase_quantity']
    end

    all_price * tax / 100
  end
end
