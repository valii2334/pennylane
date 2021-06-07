require 'rails_helper'

RSpec.describe 'FindRecipesByIngredients' do
  before do
    @grilled_cheese_sandwich = FactoryBot.create(:recipe)
    @cheese_pizza = FactoryBot.create(:recipe)
    @blt = FactoryBot.create(:recipe)

    cheese = FactoryBot.create(:ingredient, name: 'cheese')
    bread = FactoryBot.create(:ingredient, name: 'bread')
    white_flour = FactoryBot.create(:ingredient, name: 'white_flour')
    eggs = FactoryBot.create(:ingredient, name: 'eggs')
    dough = FactoryBot.create(:ingredient, name: 'dough')
    tomato_sauce = FactoryBot.create(:ingredient, name: 'tomato_sauce')
    bacon = FactoryBot.create(:ingredient, name: 'bacon')
    lettuce = FactoryBot.create(:ingredient, name: 'lettuce')
    tomato = FactoryBot.create(:ingredient, name: 'tomato')

    @grilled_cheese_sandwich.ingredients << [cheese, bread]
    @cheese_pizza.ingredients << [cheese, white_flour, eggs, dough, tomato_sauce]
    @blt.ingredients << [bread, bacon, lettuce, tomato]
  end

  it 'finds all recipes containg the ingredient' do
    found_recipes = FindRecipesByIngredients.new(['cheese']).perform

    expect(found_recipes).to match_array([@grilled_cheese_sandwich, @cheese_pizza])
  end

  it 'finds only the grilled_cheese_sandwich' do
    found_recipes = FindRecipesByIngredients.new(['cheese', 'bread']).perform

    expect(found_recipes).to match_array([@grilled_cheese_sandwich])
  end
end
