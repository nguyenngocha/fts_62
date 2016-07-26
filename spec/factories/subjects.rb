FactoryGirl.define do
  factory :subject do
    content {Faker::Lorem.sentence}
    number_of_questions 5
    duration 30

    transient do
      questions_count 5
    end

    after(:create) do |subject, evaluator|
      create_list :question, evaluator.questions_count, subject: subject
    end
  end
end
