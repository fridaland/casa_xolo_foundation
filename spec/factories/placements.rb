FactoryBot.define do
  factory :placement do
    association :parent
    association :pet
    placement_type { :foster }
    status { :active }
    start_date { 1.year.ago.to_date }

    trait :adoptive do
      placement_type { :adoptive }
    end

    trait :completed do
      status { :completed }
      end_date { 6.months.ago.to_date }
    end
  end
end
