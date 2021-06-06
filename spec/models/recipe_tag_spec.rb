require 'rails_helper'

RSpec.describe RecipeTag, type: :model do
  subject { FactoryBot.build(:recipe_tag) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :recipe_id }
  it { should have_attribute :tag_id }

  it { should belong_to(:recipe) }
  it { should belong_to(:tag) }

  ##################################
  # Validations
  ##################################

  it { should validate_uniqueness_of(:recipe_id).scoped_to(:tag_id) }
end
