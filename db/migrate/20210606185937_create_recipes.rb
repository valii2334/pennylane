class CreateRecipes < ActiveRecord::Migration[6.0]
  def change
    create_table :recipes do |t|
      t.text :name,               null: false
      t.text :author_tip
      t.integer :budget,          null: false, default: 0
      t.integer :prep_time,       null: false
      t.integer :author_id
      t.integer :difficulty,      null: false, default: 0
      t.integer :people_quantity, null: false
      t.integer :cook_time,       null: false
      t.text :image_url
      t.integer :nb_comments,     null: false, default: 0

      t.timestamps
    end

    add_check_constraint :recipes, "prep_time > 0", name: "prep_time_check"
    add_check_constraint :recipes, "cook_time > 0", name: "cook_time_check"
    add_check_constraint :recipes, "people_quantity > 0", name: "people_quantity_check"
  end
end
