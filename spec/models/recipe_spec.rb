require 'rails_helper'

RSpec.describe Recipe, type: :model do
  subject { FactoryBot.build(:recipe) }

  ##################################
  # Attribute existence
  ##################################

  it { should have_attribute :name }
  it { should have_attribute :author_tip }
  it { should have_attribute :budget }
  it { should have_attribute :prep_time }
  it { should have_attribute :author_id }
  it { should have_attribute :difficulty }
  it { should have_attribute :people_quantity }
  it { should have_attribute :cook_time }
  it { should have_attribute :image_url }
  it { should have_attribute :nb_comments }

  it { should have_many(:recipe_tags) }
  it { should have_many(:tags).through(:recipe_tags) }

  it { should have_many(:recipe_ingredients) }
  it { should have_many(:ingredients).through(:recipe_ingredients) }

  it { should belong_to(:author).optional(:true) }

  ##################################
  # Validations
  ##################################

  it { should validate_presence_of :name }

  it { should validate_numericality_of(:prep_time).is_greater_than(0) }
  it { should validate_numericality_of(:cook_time).is_greater_than(0) }
  it { should validate_numericality_of(:people_quantity).is_greater_than(0) }
  it { should validate_numericality_of(:nb_comments).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:rate).is_greater_than_or_equal_to(0) }
  it { should validate_numericality_of(:rate).is_less_than_or_equal_to(5) }

  it '#prep_time db constraint' do
    recipe = FactoryBot.create(:recipe)

    expect { recipe.update_column(:prep_time, 0) }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it '#cook_time db constraint' do
    recipe = FactoryBot.create(:recipe)

    expect { recipe.update_column(:cook_time, 0) }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it '#people_quantity db constraint' do
    recipe = FactoryBot.create(:recipe)

    expect { recipe.update_column(:people_quantity, 0) }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it '#nb_comments db constraint' do
    recipe = FactoryBot.create(:recipe)

    expect { recipe.update_column(:nb_comments, -1) }.to raise_error(ActiveRecord::StatementInvalid)
  end

  it '#rate db constraint' do
    recipe = FactoryBot.create(:recipe)

    expect { recipe.update_column(:rate, -1) }.to raise_error(ActiveRecord::StatementInvalid)
    expect { recipe.update_column(:rate, 6) }.to raise_error(ActiveRecord::StatementInvalid)
  end
end
