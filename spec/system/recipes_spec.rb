require 'rails_helper'

RSpec.describe 'RecipesController', type: :system do
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
    it 'HTML - founds recipe' do
      visit '/recipes'
      select ingredient_1.name, from: "ingredients_form_ingredient_name"
      click_button 'Add ingredient'
      expect(page).to have_content(grilled_cheese_sandwich.name)
    end
  end
end
