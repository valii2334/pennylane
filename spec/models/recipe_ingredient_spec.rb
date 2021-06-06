require 'rails_helper'

RSpec.describe RecipeIngredient, type: :model do
  subject { FactoryBot.build(:recipe_ingredient) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :recipe_id }
  it { should have_attribute :ingredient_id }

  it { should belong_to(:recipe) }
  it { should belong_to(:ingredient) }

  ##################################
  # Validations
  ##################################

  it { should validate_uniqueness_of(:recipe_id).scoped_to(:ingredient_id) }
end
