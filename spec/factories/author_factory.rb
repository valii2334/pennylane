FactoryBot.define do
  factory :author do
    name { FFaker::Name.unique }
  end
end
