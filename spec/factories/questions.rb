FactoryGirl.define do
  factory :question do
    content {Faker::Lorem.sentence}
    status 1
    subject

    factory :question_single_choice do
      question_type 0
    end

    factory :question_multiple_choice do
      question_type 1
    end

    factory :question_text do
      question_type 2
    end
  end
end
