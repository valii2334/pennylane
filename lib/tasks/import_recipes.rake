desc 'Import recipes from recipes.json'
task :import_recipes => :environment do
  stopwords = ['au', 'aux', 'avec', 'ce', 'ces', 'dans', 'de', 'des', 'du', 'elle', 'en', 'et', 'eux', 'il', 'je', 'la', 'le', 'leur', 'lui', 'ma',
    'mais', 'me', 'même', 'mes', 'moi', 'mon', 'ne', 'nos', 'notre', 'nous', 'on', 'ou', 'par', 'pas', 'pour', 'qu', 'que',
    'qui', 'sa', 'se', 'ses', 'son', 'sur', 'ta', 'te', 'tes', 'toi', 'ton', 'tu', 'un', 'une', 'vos', 'votre', 'vous',
    'c', 'd', 'j', 'l', 'à', 'm', 'n', 's', 't', 'y', 'été', 'étée', 'étées', 'étés', 'étant', 'suis', 'es', 'est', 'sommes',
    'êtes', 'sont', 'serai', 'seras', 'sera', 'serons', 'serez', 'seront', 'serais', 'serait',
    'serions', 'seriez', 'seraient', 'étais', 'était', 'étions', 'étiez', 'étaient', 'fus', 'fut',
    'fûmes', 'fûtes', 'furent', 'sois', 'soit', 'soyons', 'soyez', 'soient', 'fusse', 'fusses', 'fût',
    'fussions', 'fussiez', 'fussent', 'ayant', 'eu', 'eue', 'eues', 'eus', 'ai', 'as', 'avons', 'avez', 'ont', 'aurai',
    'auras', 'aura', 'aurons', 'aurez', 'auront', 'aurais', 'aurait', 'aurions', 'auriez', 'auraient', 'avais',
    'avait', 'avions', 'aviez', 'avaient', 'eut', 'eûmes', 'eûtes', 'eurent', 'aie', 'aies', 'ait', 'ayons', 'ayez', 'aient',
    'eusse', 'eusses', 'eût', 'eussions', 'eussiez', 'eussent', 'ceci', 'celà'  'cet', 'cette', 'ici', 'ils', 'les',
    'leurs', 'quel', 'quels', 'quelle', 'quelles', 'sans', 'soi'
  ]

  quantities = ['g', 'kg', 'cl', 'l', 'ml', 'assez', 'autant', 'beaucoup', 'bien', 'combien', 'nombreux', 'trop', 'encore',
    'majorité', 'maximum', 'minimum', 'moins', 'nombre', 'peu', 'plus', 'plupart', 'tant', 'trop', 'bouchée', 'gorgée', 'poignée', 'douzaine',
    'centaine', 'milliers', 'boîte', 'bouteille', 'carton', 'pot', 'tasse', 'verre', 'litre', 'kilo'
  ]

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

    json_tags = json_recipe['tags'].uniq
    json_ingredients = json_recipe['ingredients'].uniq

    json_ingredients.each do |ingredient|
      ingredient.gsub!(/[^A-Za-z]/i, ' ')
    end

    json_ingredients = json_ingredients.map { |ingredient|
      ingredient.split(' ')
    }.flatten

    json_ingredients = json_ingredients.map { |ingredient|
      ingredient = ingredient.downcase
      ingredient = ingredient.singularize(:fr)
    }

    json_ingredients = json_ingredients.reject { |ingredient|
      stopwords.include?(ingredient) ||
      quantities.include?(ingredient) ||
      ingredient.size < 2
    }

    json_ingredients.uniq!

    found_tags = Tag.where(name: json_tags)
    found_ingredients = Ingredient.where(name: json_ingredients)

    tags = []
    json_tags.each do |tag_name|
      tag = found_tags.select { |tag| tag.name == tag_name }.first
      tag = Tag.create(name: tag_name) unless tag
      tags << tag
    end

    ingredients = []
    json_ingredients.each do |ingredient_name|
      ingredient = found_ingredients.select { |ingredient| ingredient.name == ingredient_name }.first
      ingredient = Ingredient.create(name: ingredient_name) unless ingredient
      ingredients << ingredient
    end

    prep_time = ConvertStringToDuration.new(json_recipe['prep_time']).duration_as_integer
    cook_time = ConvertStringToDuration.new(json_recipe['cook_time']).duration_as_integer

    recipe = Recipe.create(
      rate:            json_recipe['rate'],
      description:     json_recipe['ingredients'].uniq.join(', '),
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
