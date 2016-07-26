require "rails_helper"

RSpec::Matchers.define :match_HHMMSS_time_format do |expected|
  match do |actual|
    expect(actual).to match /([01]?\d|2[0-3]):([0-5]?\d):([0-5]?\d)/
  end
end

RSpec.describe Exam, type: :model do
  describe "Associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :subject}
    it {is_expected.to have_many :results}
  end

  describe "Enums" do
    it {is_expected.to define_enum_for :status}
  end

  describe "Validations" do
    it "can be created with enough questions" do
      expect(build :exam).to be_valid
    end

    it "cannot be created without enough questions" do
      expect(build :exam_not_enough_questions).not_to be_valid
    end
  end

  describe "Callbacks" do
    it "has the correct number of results" do
      exam = create :exam
      expect(exam.results.count).to eq exam.subject.number_of_questions
    end

    it "rollbacks when fail to create results" do
      exam = build :exam
      allow(exam).to receive(:subject).and_return nil
      allow(exam).to receive(:check_number_question).and_return true
      exam.save
      expect(exam.results).to be_empty
    end
  end

  describe "Instance Methods" do
    it "calculates the correct score" do
      exam = create :exam
      create :correct_result, exam: exam
      expect(exam.calculated_score).to eq 1
    end

    it "checks results correctly" do
      exam = create :exam
      create :correct_result, exam: exam
      exam.check_results
      expect(exam.calculated_score).to eq 0
    end

    context "after 1 mins passed" do
      it "returns 1 mins as calculated spent time" do
        exam = create :exam_already_started, mins_ago: 1
        exam.update_status_exam
        expect(exam.spent_time).to eq 1.minute
      end
    end

    context "after 100 mins passed" do
      it "returns subject's duration as calculated spent time" do
        exam = create :exam_already_started, mins_ago: 100
        exam.update_status_exam
        expect(exam.spent_time).to eq exam.subject.duration.minutes
      end
    end

    context "when unchecked or checked" do
      it "returns no time remaining" do
        exam = create :exam_checked
        expect(exam.remaining_time).to eq 0
      end
    end

    context "when testing" do
      it "returns correct remaining time" do
        exam = create :exam_already_started, mins_ago: 5
        exam.update_status_exam
        expect(exam.remaining_time).to eq (exam.subject.duration.minutes - 5.minutes)
      end
    end

    it "returns spent time in HH:MM:SS format" do
      exam = create :exam_already_started, mins_ago: 5
      exam.update_status_exam
      expect(exam.spent_time_format).to match_HHMMSS_time_format
    end
  end
end
