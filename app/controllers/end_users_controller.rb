class EndUsersController < ApplicationController

	def show
		@user = EndUser.find(params[:id])
		@myfavorites = @user.favorites.page(params[:page]).per(10).order(id: "DESC")
		addresses = @user.addresses
		sub_address = []
		addresses.each do |address|
			unless address['main_flag']
				sub_address.push(address)
			end
		end
		@myaddresses = sub_address
	end

	def unsubscribe

	end

	def edit
		@user = EndUser.find(params[:id])
	end

	def update
		user = EndUser.find(params[:id])
		user.update(end_user_params)
		redirect_to end_user_path(current_end_user.id)
	end

	def delete
		if unsubscriber = EndUser.find_by(email:params[:unsubscribe_email])
			if current_end_user.id == unsubscriber.id
				current_end_user.delete_flag = true
				redirect_to destroy_end_user_session_path, method: :delete
			end
		end
			redirect_to end_items_path
	end

	private
		def end_user_params
			params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :usually_payment, addresses_attributes: [:postal_code, :address, :telephone_number, :_destroy, :id])
		end
end
