module EndUsersHelper
  def full_name(end_user_model)
    "#{end_user_model['last_name']}#{end_user_model['first_name']}"
  end
end
