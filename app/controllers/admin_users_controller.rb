class AdminUsersController < ApplicationController
	def index
    	users = EndUser.all

			un_delete_users = []
			users.each do |user|
				unless user['delete_flag']
					un_delete_users.push(user)
				end
			end

			@users = un_delete_users
	end

	def edit
		@user = EndUser.find(params[:id])
		if @user['delete_flag']
			redirect_to admin_users_path
		end
	end

	def update
		user = EndUser.find(params[:id])
		user.update(end_user_params)

		redirect_to admin_users_path
	end

	def destroy
		user = EndUser.find(params[:id])
		user['delete_flag'] = true
		user.save

		redirect_to admin_users_path
	end

	def search
		users = EndUser.all
		match_user_array = []
		users.each do |user|
			unless user['delete_flag']
				full_name = user['last_name'] + user['first_name']
				if full_name.include?(params['search_word'])
					match_user_array.push(user)
				end
			end
		end
		@users = match_user_array
	end

	private
		def end_user_params
			params.require(:end_user).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :usually_payment, addresses_attributes: [:postal_code, :address, :telephone_number, :_destroy, :id])
		end
end
