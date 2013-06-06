FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "John-#{n}" }
    sequence(:last_name) { |n| "Doe-#{n}" }
    sequence(:email) { |n| "some-email-#{n}@kole.dev" }

    password              '123123123'
    password_confirmation '123123123'

    before(:create) do |user|
      create(:company).users << user
    end
  end
end
