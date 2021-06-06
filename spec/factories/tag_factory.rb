FactoryBot.define do
  factory :tag do
    name { FFaker::Lorem.unique.word }
  end
end
