FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Animal.name.split.map(&:capitalize).join(" ") }
    species { Pet.species.keys.sample }
    breed { "Mixed" }
    sex { Pet.sexes.keys.sample }
    color { Faker::Color.color_name.capitalize }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    status { :available }

    trait :adopted do
      status { :adopted }
    end

    trait :urgent do
      status { :urgent }
    end

    trait :with_photo do
      after(:create) do |pet|
        pet.photos.attach(
          io: File.open(Rails.root.join("spec/fixtures/files/cat_salem.jpg")),
          filename: "pet_photo.jpg",
          content_type: "image/jpeg"
        )
      end
    end
  end
end
