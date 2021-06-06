class Tag < ApplicationRecord
  has_many :recipe_tags
  has_many :tags, through: :recipe_tags

  validates :name, presence: true, uniqueness: true
end
