FactoryBot.define do
  factory :bookmark do
    url { "https://www.youtube.com/watch?v=ABCDEFGHIJK" }
    video_id { "ABCDEFGHIJK" }
  end
end
