FactoryBot.define do
  factory :timestamp do
    hour { 0 }
    sequence(:minute) { |n| n }
    sequence(:second) { |n| n }
    sequence(:start_time) { |n| 0 + n.to_i * 60 + n.to_i }
  end
end
