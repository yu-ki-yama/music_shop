module AdminPurchaseHistoriesHelper
  def address_name_arrays(address_model)
    arrays = []
    address_model.each do |address|
      address_name_array = []
      address_name_array.push(address['name'])
      address_name_array.push(address['id'])
      arrays.push(address_name_array)
    end
    arrays
  end

end
