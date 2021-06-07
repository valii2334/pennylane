class IngredientsController < ApplicationController
  def index
    ingredients = Ingredient.where("name like ?", "%#{params[:ingredient_name]}%")

    respond_to do |format|
      format.json { render json: ingredients, each_serializer: IngredientSerializer }
    end
  end
end
