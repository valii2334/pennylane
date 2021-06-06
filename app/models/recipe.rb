class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  has_one :author

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
end
