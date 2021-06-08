desc 'Import recipes from recipes.json'
task :import_recipes => :environment do
  Author.delete_all
  Recipe.delete_all
  Tag.delete_all
  Ingredient.delete_all
  RecipeIngredient.delete_all
  RecipeTag.delete_all

  json_recipes = JSON.parse(
    File.read(Rails.root.join('lib/tasks/recipes.json'))
  )

  recipe_tags = []
  recipe_ingredients = []

  json_recipes.each_with_index do |json_recipe, index|
    puts "Processing recipe #{index + 1}"
    author = Author.find_or_create_by(name: json_recipe['author'])

    found_tags = Tag.where(name: json_recipe['tags'].uniq)
    found_ingredients = Ingredient.where(name: json_recipe['ingredients'].uniq)

    tags = []
    json_recipe['tags'].uniq.each do |tag_name|
      tag = found_tags.select { |tag| tag.name == tag_name }.first
      tag = Tag.create(name: tag_name) unless tag

      tags << tag
    end

    ingredients = []
    json_recipe['ingredients'].uniq.each do |ingredient_name|
      ingredient = found_ingredients.select { |ingredient| ingredient.name == ingredient_name }.first
      ingredient = Ingredient.create(name: ingredient_name) unless ingredient
      ingredients << ingredient
    end

    prep_time = ConvertStringToDuration.new(json_recipe['prep_time']).duration_as_integer
    cook_time = ConvertStringToDuration.new(json_recipe['cook_time']).duration_as_integer

    recipe = Recipe.create(
      rate:            json_recipe['rate'],
      author_tip:      json_recipe['author_tip'].empty? ? nil : json_recipe['author_tip'],
      budget:          json_recipe['budget'].downcase.gsub(' ', '_'),
      prep_time:       prep_time,
      name:            json_recipe['name'],
      author_id:       author.id,
      difficulty:      json_recipe['difficulty'].downcase.gsub(' ','_'),
      people_quantity: json_recipe['people_quantity'],
      cook_time:       cook_time,
      image_url:       json_recipe['image'].empty? ? nil : json_recipe['image'],
      nb_comments:     json_recipe['nb_comments']
    )

    ingredients.each do |ingredient|
      recipe_ingredients << { recipe_id: recipe.id, ingredient_id: ingredient.id }
    end

    tags.each do |tag|
      recipe_tags << { recipe_id: recipe.id, tag_id: tag.id }
    end
  end

  RecipeTag.import recipe_tags
  RecipeIngredient.import recipe_ingredients
end
