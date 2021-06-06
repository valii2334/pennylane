FactoryBot.define do
  factory :ingredient do
    name { FFaker::Lorem.unique.word }
  end
end
