class AdminPurchaseHistoriesController < ApplicationController
  def index
    @purchase_histories = PurchaseDetail.where(shipping_status: '受付中')
  end

  def show
    @purchase_detail = PurchaseDetail.find(params['id'])

    purchase_details = PurchaseDetail.where(purchase_history_id: @purchase_detail.purchase_history['id'])

    history_details = []
    purchase_details.each do |history|
      unless history['id'] == params['id']
        history_details.push(history)
      end
    end

    @sub_purchase_details = history_details

    @purchase_history = @purchase_detail.purchase_history
  end

  def update
    purchase_history = PurchaseDetail.find(params[:id])

    if purchase_history['shipping_status'] == '受付中'
      purchase_history['shipping_status'] = '準備中'
      purchase_history.save
    elsif purchase_history['shipping_status'] == '準備中'
      purchase_history['shipping_status'] = '発送済'
      purchase_history.save
    end

    @purchase_histories = PurchaseDetail.where(shipping_status: '受付中')

  end

  def search

    @select_mode = params['format']
    if params['format'] == '全表示'
      @purchase_histories = PurchaseDetail.all
    else
      @purchase_histories = PurchaseDetail.where(shipping_status: params['format'])
    end


  end

  private
  def purchase_history_params
      params.repuire(:purchase_details).permit(:shipping_status)
  end
end
