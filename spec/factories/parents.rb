FactoryBot.define do
  factory :parent do
    family_name { "#{Faker::Name.last_name} Family" }
    primary_contact_name { Faker::Name.name }
    primary_contact_email { Faker::Internet.email }
    parent_type { :foster }
    status { :active }
    start_date { 1.year.ago.to_date }
    association :pet

    trait :adoptive do
      parent_type { :adoptive }
      status { :completed }
    end

    trait :without_pet do
      pet { nil }
    end
  end
end
