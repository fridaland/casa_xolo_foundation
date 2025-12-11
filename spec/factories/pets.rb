FactoryBot.define do
  factory :pet do
    name { "Sabrina Carpenter" }
    species { :cat }
    breed { "Mixed" }
    sex { :female }
    color { "Tortie" }
    description { "A sweet and playful tortoiseshell cat looking for a loving home." }
  end
end
