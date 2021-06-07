class FindRecipesByIngredients
  def initialize(ingredients_names)
    @ingredients_ids = Ingredient.where(name: ingredients_names).pluck(:id)
  end

  def perform
    recipe_ids = RecipeIngredient.where(ingredient_id: @ingredients_ids).pluck(:recipe_id)
    recipe_ids_containing_all_ingredients = []

    recipe_ids.each do |recipe_id|
      if recipe_ids.count(recipe_id).eql?(@ingredients_ids.size)
        recipe_ids_containing_all_ingredients << recipe_id
      end
    end

    Recipe.where(id: recipe_ids_containing_all_ingredients.uniq)
          .includes(:ingredients, :tags, :author)
  end
end
