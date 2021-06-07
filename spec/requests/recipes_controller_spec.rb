require 'rails_helper'

RSpec.describe 'RecipesController', type: :request do
  let(:grilled_cheese_sandwich) { FactoryBot.create(:recipe) }
  let(:ingredient_1) { FactoryBot.create(:ingredient) }
  let(:ingredient_2) { FactoryBot.create(:ingredient) }
  let!(:grilled_cheese_sandwich_cheese_ingredient) {
    FactoryBot.create(
      :recipe_ingredient,
      recipe: grilled_cheese_sandwich,
      ingredient: ingredient_1
    )
  }
  let!(:grilled_cheese_sandwich_bread_ingredient) {
    FactoryBot.create(
      :recipe_ingredient,
      recipe: grilled_cheese_sandwich,
      ingredient: ingredient_2
    )
  }

  context '/recipes' do
    it 'HTML - returns 200' do
      get recipes_path

      expect(status).to eq(200)
    end

    it 'JSON - returns found recipes serialized' do
      params = {
        format: 'json',
        ingredients_names: [ingredient_1.name]
      }

      get recipes_path, params: params

      expected_result = [{
        "id" => grilled_cheese_sandwich.id,
        "author_tip" => nil,
        "prep_time" => grilled_cheese_sandwich.prep_time,
        "cook_time" => grilled_cheese_sandwich.cook_time,
        "total_time" => grilled_cheese_sandwich.total_time,
        "difficulty" => grilled_cheese_sandwich.difficulty,
        "budget" => grilled_cheese_sandwich.budget,
        "rate" => nil,
        "ingredients_names" => [ingredient_1.name, ingredient_2.name],
        "tags_names" => [],
        "author_name" => nil
      }]

      json_response = JSON.parse(response.body)

      expect(json_response).to eq(expected_result)
    end
  end
end
