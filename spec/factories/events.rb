FactoryBot.define do
  factory :event do
    name { Faker::Lorem.words(number: 3).map(&:capitalize).join(" ") }
    event_date { Faker::Time.forward(days: 30) }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
