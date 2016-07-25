FactoryGirl.define do
  factory :answer do
    content {Faker::Lorem.sentence}
    question

    factory :correct_answer do
      is_correct true
    end

    factory :incorrect_answer do
      is_correct false
    end
  end
end
