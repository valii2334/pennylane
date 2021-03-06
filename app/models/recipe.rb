class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  belongs_to :author, optional: true

  enum budget: [
    :bon_marché,
    :coût_moyen,
    :assez_cher
  ]
  enum difficulty: [
    :très_facile,
    :niveau_moyen,
    :facile,
    :difficile
  ]

  validates :name,            presence: true
  validates :prep_time,       numericality: { greater_than: 0 }
  validates :people_quantity, numericality: { greater_than: 0 }
  validates :cook_time,       numericality: { greater_than: 0 }
  validates :nb_comments,     numericality: { greater_than_or_equal_to: 0 }
  validates :rate,            numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 },
                              allow_nil: true

  def total_time
    prep_time + cook_time
  end

  def pretty_difficulty
    difficulty.gsub('_', ' ')
  end

  def pretty_budget
    budget.gsub('_', ' ')
  end
end
