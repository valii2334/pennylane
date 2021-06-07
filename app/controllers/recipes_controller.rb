# frozen_string_literal: true

class RecipesController < ApplicationController
  def index
    unless (session[:ingredients] || params[:ingredients_names] || []).empty?
      @recipes = FindRecipesByIngredients.new(session[:ingredients]).perform
    else
      @recipes = []
    end

    respond_to do |format|
      format.html
      format.json { render json: @recipes }
    end
  end

  def add_ingredient_to_session
    session[:ingredients] ||= []
    session[:ingredients] << params[:ingredients_form][:ingredient_name]

    redirect_to :root
  end

  def remove_ingredient_from_session
    session[:ingredients].delete(params[:ingredient_name])

    redirect_to :root
  end
end
