FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Games::Pokemon.name }
    profile { Faker::Games::Pokemon.move }
  end
end
