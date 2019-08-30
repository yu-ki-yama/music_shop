class AdminItemsController < ApplicationController
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @disc = @item.discs.build
    @music = @disc.musics.build
    @genre = Genre.all
    @label = Label.all
  end

  def edit
    item = Item.find(params['id'])
    item['artist_id'] = Artist.find(item['artist_id'])['artist_name']
    @item = item
    @genre = Genre.all
    @label = Label.all
    @tax = 108
  end

  def create
    artist = Artist.where(artist_name: item_params['artist_id'])
    if artist.blank?
      artist = Artist.create(artist_name: item_params['artist_id'])
    else
      artist = artist[0]
    end

    update_params = item_params

    if item_params['item_image'] == '{}'
      update_params['item_image'] = File.open("./app/assets/images/music.jpeg")
    end

    if item_params['price'] == ''
      update_params['price'] = 0
    end

    if item_params['stock'] == ''
      update_params['stock'] = 0
    end

    item = Item.new(update_params)
    item['sale_number'] = 0
    item['artist_id'] = artist['id']
    item.save

    redirect_to admin_items_path
  end

  def update
    artist = Artist.where(artist_name: item_params['artist_id'])
    if artist.blank?
      artist = Artist.create(artist_name: item_params['artist_id'])
    else
      artist = artist[0]
    end

    update_item = item_params
    update_item['artist_id'] = artist['id']
    item = Item.find(params['id'])

    if item_params['item_image_id'].nil?
      update_item['item_image_id'] = item['item_image_id']
      item.update(update_item)
    else
      item.update(update_item)
    end

    redirect_to admin_items_path
  end

  def destroy
    Item.find(params['id']).destroy
    redirect_to admin_items_path
  end

  def search

    if params['search_method'] == "item_name"
      @items = Item.where('item_name LIKE ?', "%#{params['search_word']}%")

    elsif params['search_method'] == "item_stock"

      if params["condition"] == "以上"
        @items = Item.where("stock >= ?", params['number'])
      elsif params["condition"] == "以下"
        @items = Item.where("stock <= ?", params['number'])
      else
        @items = Item.where(stock: params['number'])
      end

    elsif params['search_method'] == "item_condition"
        @items = Item.where(sale_condition: params['sale_condition'])

    end

  end

  private
  def item_params
    params.require(:item).permit(:artist_id, :genre_id, :label_id,:item_name,:item_image,:price,:stock,:sale_condition,discs_attributes: [:id, :disc_number, :_destroy, musics_attributes: [:id, :music_name, :music_order, :_destroy]])
  end

end
