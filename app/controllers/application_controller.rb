# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:home]

  def home
    # recipe:
    #   - name: text, null: false
    #   - author_tip: text
    #   - budget: enum
    #   - prep_time: integer -> seconds not null
    #   - author_id: integer not null
    #   - difficulty enum
    #   - people_quantity integer greater or equal with 1
    #   - cook_time integer -> seconds not null
    #   - total_time - method
    #   - image_url text can be null
    #   - nb_comments integer
    #
    #   tags
    #     - name unique true
    #
    #   author
    #     - name unique true
    #
    #   ingredient
    #     - name unique true
    #
    #   recipe_tags
    #     - recipe_id
    #     - tag_id
    #
    #   recipe_ingredients
    #     - recipe_id
    #     - ingredient_id
    #
    # {
    #   "rate": "5",
    #   "author_tip": "",
    #   "budget": "bon marché",
    #   "prep_time": "15 min",
    #   "ingredients": [
    #     "600g de pâte à crêpe",
    #     "1/2 orange",
    #     "1/2 banane",
    #     "1/2 poire pochée",
    #     "1poignée de framboises",
    #     "75g de Nutella®",
    #     "1poignée de noisettes torréfiées",
    #     "1/2poignée d'amandes concassées",
    #     "1cuillère à café d'orange confites en dés",
    #     "2cuillères à café de noix de coco rapée",
    #     "1/2poignée de pistache concassées",
    #     "2cuillères à soupe d'amandes effilées"
    #   ],
    #   "name": "6 ingrédients que l’on peut ajouter sur une crêpe au Nutella®",
    #   "author": "Nutella",
    #   "difficulty": "très facile",
    #   "people_quantity": "6",
    #   "cook_time": "10 min",
    #   "tags": [
    #     "Crêpe",
    #     "Crêpes sucrées",
    #     "Végétarien",
    #     "Dessert"
    #   ],
    #   "total_time": "25 min",
    #   "image": "https://assets.afcdn.com/recipe/20171006/72810_w420h344c1cx2544cy1696cxt0cyt0cxb5088cyb3392.jpg",
    #   "nb_comments": "1"
    # }
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
    devise_parameter_sanitizer.permit(:account_update)
  end
end
