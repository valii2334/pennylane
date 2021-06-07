class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :author_tip, :prep_time, :cook_time, :total_time,
            :difficulty, :budget, :rate, :ingredients_names, :tags_names,
            :author_name

  def ingredients_names
    object.ingredients.pluck(:name)
  end

  def tags_names
    object.tags.pluck(:name)
  end

  def author_name
    object.author.try(:name)
  end
end
