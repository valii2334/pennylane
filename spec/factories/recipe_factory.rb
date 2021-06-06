FactoryBot.define do
  factory :recipe do
    name            { FFaker::Lorem.word }
    budget          { 'bon_marché' }
    prep_time       { 60 }
    difficulty      { 'très_facile' }
    people_quantity { 4 }
    cook_time       { 120 }
  end
end
