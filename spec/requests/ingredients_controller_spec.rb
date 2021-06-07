require 'rails_helper'

RSpec.describe 'IngredientsController', type: :request do
  let(:ingredient_1) { FactoryBot.create(:ingredient) }
  let(:ingredient_2) { FactoryBot.create(:ingredient) }

  context '/ingredients' do
    it 'JSON - returns found recipes serialized' do
      params = {
        format: 'json',
        ingredient_name: ingredient_1.name
      }

      get ingredients_path, params: params

      expected_result = [{
        "name" => ingredient_1.name
      }]

      json_response = JSON.parse(response.body)

      expect(json_response).to eq(expected_result)
    end
  end
end
