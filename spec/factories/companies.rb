FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "Virtual Co-#{n}" }
  end
end
