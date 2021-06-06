require 'rails_helper'

RSpec.describe Author, type: :model do
  subject { FactoryBot.build(:author) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :name }

  it { should have_many(:recipes) }

  ##################################
  # Validations
  ##################################

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
