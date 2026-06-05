FactoryBot.define do
  factory :volunteer_application do
    name     { Faker::Name.name }
    email    { Faker::Internet.email }
    phone    { Faker::PhoneNumber.phone_number }
    position { VolunteerApplication::POSITIONS.sample }
    message  { Faker::Lorem.paragraph(sentence_count: 2) }
  end
end
