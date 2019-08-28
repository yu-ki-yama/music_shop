class EndItemsController < ApplicationController

	def index
		@tax_rate = "1.08"
		@new_items = Item.includes(:artist).page(params[:new_page]).per(4).order(id: "DESC")
		@cheap_items = Item.includes(:artist).where("price <= ?", (BigDecimal("1000") * BigDecimal(@tax_rate)).ceil).page(params[:cheap_page]).where.not(stock: 0, sale_condition: 1).per(4).order(id: "DESC")
		@few_items = Item.includes(:artist).where(stock: 1..5).page(params[:few_page]).where.not(stock: 0, sale_condition: 1).per(4).order(id: "DESC")
		@all_items = Item.includes(:artist).page(params[:all_page]).per(20).order(id: "DESC")
		respond_to do |format|
			format.html
			format.js
		end
		@ranking = Item.includes(:artist).order(sale_number: "DESC").limit(10)
	end

	def search
		if params[:search]
			@items = Item.includes(:artist).where('item_name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(10).order(id: "DESC")
		else
			redirect_to end_items_path
		end
		@tax_rate = "1.08"
		@ranking = Item.includes(:artist).order(sale_number: "DESC").limit(10)
	end

	def show
		@tax_rate = "1.08"
		@item = Item.find(params[:id])
	end
end
