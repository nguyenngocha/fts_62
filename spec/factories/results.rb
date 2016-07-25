FactoryGirl.define do
  factory :result do
    exam
    question

    factory :correct_result do
      is_correct 1
    end
  end
end
