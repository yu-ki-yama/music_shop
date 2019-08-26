# frozen_string_literal: true

class EndUsers::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = EndUser.find_by(email: params['end_user']['email'])

    if user.blank?
      session[:login_error] = true
      session[:error] = "メールアドレスかパスワードが間違っています"
      redirect_to new_end_user_session_path
    elsif user['delete_flag']
      session[:login_error] = true
      session[:error] = "このユーザーはすでに退会されています"
      redirect_to new_end_user_session_path
    else
      super
    end

  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
