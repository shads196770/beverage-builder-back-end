class BeveragesController < ApplicationController
  before_action :set_beverage, only: [:show, :update, :destroy]

  def index
    @beverages = Beverage.all

    render json: @beverages
  end

  def show
    render json: @beverage
  end

  def create
    @beverage = Beverage.new(name: beverage_params[:name])

    if @beverage.save
      render json: @beverage, status: :created
    else
      render json: @beverage.errors, status: :internal_server_error
    end
  end

  def update
    if @beverage.update(beverage_params)
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
    params.require(:beverage).permit(:id, :name, recipe: [:name, :parts])
  end
end
