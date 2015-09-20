class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :update, :destroy]

  def index
    @recipes = Recipe.all

    render json: @recipes
  end

  def show
    render json: @recipe
  end

  def create
    @recipe = Recipe.new(recipe_params)

    if @recipe.save
      render json: @recipe, status: :created
    else
      render json: @recipe.errors, status: :internal_server_error
    end
  end

  def update
    if @recipe.update(recipe_params)
      head :no_content
    else
      render json: @recipe.errors, status: :internal_server_error
    end
  end

  def destroy
    if @recipe.destroy
      head :no_content
    else
      render json: @recipe.errors, status: :internal_server_error
    end
  end

  private

  def set_recipe
    @recipe = Recipe.where(beverage_id: params[:beverage_id])
  end

  def recipe_params
    params.require(:recipe).permit(:id, :beverage_id, :ingredient_id, :parts)
  end
end
