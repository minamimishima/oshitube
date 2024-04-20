FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 8, max_length: 30) }
    name { Faker::Games::Pokemon.name }
    profile { Faker::Games::Pokemon.move }
  end
end
