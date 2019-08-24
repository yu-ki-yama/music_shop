class EndAddressesController < ApplicationController

  def new
    @user = Address.new
  end

  def create
    user = Address.new(address_params)
    user["end_user_id"] = current_end_user["id"]
    user["main_flag"] = false
    user.save
    redirect_to end_user_path(current_end_user.id)
  end

  def destroy
    user = Address.find(params[:id])
    user.destroy
    redirect_to end_user_path(current_end_user.id)
  end


  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address, :telephone_number)

  end
end