FactoryBot.define do
  factory :newsletter_subscription do
    email { Faker::Internet.unique.email }
  end
end
