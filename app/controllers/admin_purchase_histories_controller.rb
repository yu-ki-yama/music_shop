class AdminPurchaseHistoriesController < ApplicationController
  def index
    @purchase_histories = PurchaseDetail.all
  end
  def show
    @purchase_history = PurchaseDetail.find(params[:id])
    history = PurchaseHistory.find(@purchase_history.purchase_history_id)
    @user_id = history.end_user_id
    user = EndUser.find(history.end_user_id)
    @last_name = user.last_name
    @first_name = user.first_name
  end
  def update
    purchase_history = PurchaseDetail.update
    purchase_history.update(purchase_history_params)
  end
  def search
    @purchase_histories = PurchaseDetail.where('shipping_status LIKE ?', "%#{params[:shipping_status]}" )
  end

  private
  def purchase_history_params
      params.repuire(:purchase_details).permit(:shipping_status)
  end
end
