class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

 
  def index
    @items = Item.all
    render json: @items, status: 200
  end


  def show
    @item = Item.find(params[:id])

    if @item 
      render json: @item, status: 200
    else
      render json: @item.errors, status: 404
    end

  end


  def create
    @item = Item.new(item_params)

      if @item.save
        render json: @item, status: :created
      else
        render json: @item.errors, status: :unprocessable_entity
      end

  end


  def update
    if @item.update(item_params)
      render json: @item, status: :ok
    else
      render json: @item.errors, status: :unprocessable_entity 
    end
  end

 
  def destroy
    @item.destroy
      if @item.destroy
        render json: { message: 'Item was successfully deleted.' }, status: 200
      else 
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
      if @item.nil?
        render json: { error: 'Cannot find item by that id' }, status: 404
      else
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.fetch(:item, {}).permit(:name, :price)
    end

end