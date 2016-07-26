require 'rails_helper'

RSpec.describe Result, type: :model do
  describe "Associations" do
    it {is_expected.to belong_to :exam}
    it {is_expected.to belong_to :question}
    it {is_expected.to belong_to :answer}
    it {is_expected.to have_one :text_answer}
    it {is_expected.to accept_nested_attributes_for :text_answer}
  end

  describe "Callbacks" do
    it "creates text answer for text answer type question" do
      question = create :question_text
      expect {create :result, question: question}.to change {TextAnswer.count}.by 1
    end
  end

  describe "Scopes" do
    it "scopes correct results" do
      create_list :result, 3
      create_list :correct_result, 2
      expect(Result.correct).to eq Result.where is_correct: true
    end
  end

  describe "Instance Methods" do
    let :question_multiple_choice do
      question = create :question_multiple_choice
      create :correct_answer, question: question
      create :incorrect_answer, question: question
      question
    end

    context "multiple choice question, all correct answers" do
      it "is a correct result" do
        result = create :result, question: question_multiple_choice
        question_multiple_choice.answers.each do |answer|
          result.answer_ids << answer.id if answer.is_correct
        end
        result.check_result
        expect(result.is_correct).to be true
      end
    end

    context "multiple choice question, one incorrect_answer" do
      it "is an incorrect result" do
        result = create :result, question: question_multiple_choice
        question_multiple_choice.answers.each do |answer|
          result.answer_ids << answer.id
        end
        result.check_result
        expect(result.is_correct).to be false
      end
    end

    context "single choice question, correct answer" do
      it "is a correct result" do
        question = create :question_single_choice
        correct_answer = create :correct_answer, question: question
        create_list :incorrect_answer, 3, question: question
        result = create :result, question: question
        result.answer_id = correct_answer.id
        result.check_result
        expect(result.is_correct).to be true
      end
    end

    context "text answer question, user text answer match answer text answer" do
      it "is a correct result" do
        question = create :question_text
        correct_answer = create :correct_answer, question: question
        result = create :result, question: question
        result.text_answer.content = correct_answer.content
        result.check_result
        expect(result.is_correct).to be true
      end
    end
  end
end
