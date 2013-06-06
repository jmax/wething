FactoryGirl.define do
  factory :thing do
    user

    sequence(:url) { |n| "http://www.some-thing-url-#{n}.com" }
    description "Something to say"

    before(:create) do |thing|
      thing.company = user.company
    end
  end
end
