desc 'Import recipes from recipes.json'
task :import_recipes => :environment do
  json_recipes = JSON.parse(
    File.read(Rails.root.join('lib/tasks/recipes.json'))
  )
end
