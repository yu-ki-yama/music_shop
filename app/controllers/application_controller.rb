class ApplicationController < ActionController::Base
  before_action :authenticate_user

  def after_sign_in_path_for(resource)
    case resource
    when AdminUser
      admin_purchase_histories_path
    when EndUser
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    if resource.equal?(:admin_user)
      new_admin_user_session_path
    else
      root_path
    end
  end

  def authenticate_user
    puts '0000000000000000000000'
    puts params['controller']
    puts params['action']
    puts params.inspect

    if params["controller"] == 'end_users/sessions' && params["action"] == 'new' || params["action"] == 'create'
      # アクセスを許可する
    elsif params["controller"] == 'admin_users/sessions' && params["action"] == 'new' || params["action"] == 'create'
      # アクセスを許可する
    elsif params["controller"] == 'end_items' && params["action"] == 'index' || params["action"] == 'show'
      # アクセスを許可する
    elsif params["controller"] == 'end_users/registrations' && params["action"] == 'new' || params["action"] == 'create'
      # アクセスを許可する
    elsif params["controller"].split("_")[0] == 'admin'

      unless admin_user_signed_in?
        redirect_to new_admin_user_session_path
      end

    elsif params["controller"].split("_")[0] == 'end'

      unless end_user_signed_in?
        redirect_to new_end_user_session_path
      end

    end

  end

end
