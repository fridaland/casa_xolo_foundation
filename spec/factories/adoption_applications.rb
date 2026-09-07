FactoryBot.define do
  factory :adoption_application do
    association :pet
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email }
    phone { "555-867-5309" }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    housing_type { AdoptionApplication::HOUSING_TYPES.first }
    owns_or_rents { AdoptionApplication::OWNERSHIP_OPTIONS.first }
    has_yard { AdoptionApplication::YARD_OPTIONS.first }
    has_other_pets { AdoptionApplication::YES_NO_OPTIONS.last }
    has_children { AdoptionApplication::YES_NO_OPTIONS.last }
    pet_experience { Faker::Lorem.paragraph(sentence_count: 2) }
    adoption_reason { Faker::Lorem.paragraph(sentence_count: 2) }
    application_type { "adoption" }

    trait :foster do
      application_type { "foster" }
    end
  end
end
