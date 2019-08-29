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

    # if params["controller"].split("_")[0] == 'admin'
    #   unless admin_user_signed_in?
    #     # redirect_to
    #   end
    #
    # elsif params["controller"].split("_")[0] == 'end'
    #   puts '----------------------'
    #   puts end_user_signed_in?
    #
    # end

  end

end
