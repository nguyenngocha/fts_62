FactoryGirl.define do
  factory :exam do
    subject {create :subject}

    factory :exam_not_enough_questions do
      subject {create :subject, questions_count: 3}
    end

    factory :exam_already_started do
      status 1

      transient do
        mins_ago 0
      end

      after(:create) do |exam, evaluator|
        exam.started_at = Time.now - evaluator.mins_ago.minutes
      end
    end

    factory :exam_checked do
      status 3
    end
  end
end
