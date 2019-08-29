class EndPurchaseHistoriesController < ApplicationController
  def index
    @purchase_histories = PurchaseHistory.where(end_user_id: current_end_user['id']).order(id: "DESC").page(params[:page]).per(1)
  end
end
