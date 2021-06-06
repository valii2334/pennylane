require 'rails_helper'

RSpec.describe Tag, type: :model do
  subject { FactoryBot.build(:tag) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :name }

  it { should have_many(:recipe_tags) }
  it { should have_many(:recipes).through(:recipe_tags) }

  ##################################
  # Validations
  ##################################

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
