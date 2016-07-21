FactoryGirl.define do
  factory :subject do
    content {Faker::Lorem.sentence}
    number_of_questions 20
    duration 30
  end
end
