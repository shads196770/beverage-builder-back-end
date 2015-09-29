class BeveragesController < ApplicationController
  before_action :set_beverage, only: [:show, :update, :destroy]

  def index
    @beverages = Beverage.all.order(:name)

    render json: @beverages
  end

  def show
    render json: @beverage
  end

  def create
    @beverage = Beverage.new(name: beverage_params[:name])

    if @beverage.save
      @beverage.recipes.new(beverage_params[:recipe])
      @beverage.save

      render json: @beverage, status: :created
    else
      render json: @beverage.errors, status: :internal_server_error
    end
  end

  def update
    if @beverage.update(name: beverage_params[:name])
      Recipe.update_recipe(beverage_params[:id], beverage_params[:recipe])
      @beverage.touch

      head :no_content
    else
      render json: @beverage.errors, status: :internal_server_error
    end
  end

  def destroy
    if @beverage.destroy
      head :no_content
    else
      render json: @beverage.errors, status: :internal_server_error
    end
  end

  private

  def set_beverage
    @beverage = Beverage.find(params[:id])
  end

  def beverage_params
    params.require(:beverage).permit(:id, :name, recipe: [:beverage_id, :ingredient_id, :name, :parts])
  end
end
