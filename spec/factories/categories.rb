FactoryBot.define do
  factory :category do
    name { Faker::JapaneseMedia::KamenRider.series(:heisei) }
    association :user
  end
end
