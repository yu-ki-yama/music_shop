class ApplicationController < ActionController::Base
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
end
