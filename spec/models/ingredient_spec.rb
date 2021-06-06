require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  subject { FactoryBot.build(:ingredient) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :name }

  it { should have_many(:recipe_ingredients) }
  it { should have_many(:recipes).through(:recipe_ingredients) }

  ##################################
  # Validations
  ##################################

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
