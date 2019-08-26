class EndFavoritesController < ApplicationController

    before_action :set_variables

	def favorite
        favorite = current_end_user.favorites.new(item_id: @item.id)
        favorite.save
    end
    def unfavorite
        favorite = current_end_user.favorites.find_by(item_id: @item.id)
        favorite.destroy
    end

    private
        def set_variables
            @item = Item.find(params[:end_item_id])
            @id_name = "#favorite-link-#{@item.id}"
            @id_heart = "#heart-#{@item.id}"
        end
end
