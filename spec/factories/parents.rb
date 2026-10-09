FactoryBot.define do
  factory :parent do
    family_name { "#{Faker::Name.last_name} Family" }
    primary_contact_name { Faker::Name.name }
    primary_contact_email { Faker::Internet.email }
  end
end
