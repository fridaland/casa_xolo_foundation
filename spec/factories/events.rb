FactoryBot.define do
  factory :event do
    name { Faker::Lorem.words(number: 3).map(&:capitalize).join(" ") }
    event_date { Faker::Time.forward(days: 30) }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    signup_url { nil }

    trait :with_signup_url do
      signup_url { Faker::Internet.url }
    end
  end
end
