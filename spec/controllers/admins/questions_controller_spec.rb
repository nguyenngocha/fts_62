require "rails_helper"

RSpec.describe Admins::QuestionsController, type: :controller do
  let(:admin) {FactoryGirl.create :admin}
  let :attr_true do
    FactoryGirl.attributes_for :question, subject_id: 1,
    content: Faker::Lorem.sentence,
    question_type: Settings.questions.single_choice,
    status: Settings.questions.approved, answers_attributes:
    {"0": {content: Faker::Lorem.sentence, is_correct: 0, _destroy: false}}
  end
  let :attr_false do
    FactoryGirl.attributes_for :question, subject_id: 1,
    content: nil, question_type: Settings.questions.single_choice,
    status: Settings.questions.approved, answers_attributes:
    {"0": {content: Faker::Lorem.sentence, is_correct: 0, _destroy: false}}
  end

  before {sign_in admin}

  describe "#new" do
    it do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#show" do
    let(:question) {FactoryGirl.create :question}
    it do
      get :show, id: question.id
      expect(response).should render_template "admins/questions/show"
    end
  end

  describe "#index" do
    it do
      get :index
      expect(response).to render_template "admins/questions/index"
    end
  end

  describe "#create" do
    it "crete success" do
      post :create, question: attr_true
      expect(response).to redirect_to admins_questions_path
    end

    it "create fail" do
      post :create, question: attr_false
      expect(response).to render_template :new
    end
  end

  describe "#update" do
    let(:question) {FactoryGirl.create :question}
    before {request.env["HTTP_REFERER"] = "/admins/questions"}

    it "update success" do
      patch :update, id: question.id, question: attr_true
      expect(flash[:success]).to be_present
      expect(response).to redirect_to admins_questions_path
    end

    it "update fail" do
      patch :update, id: question.id, question: attr_false
      expect(flash[:danger]).to be_present
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    let(:question) {FactoryGirl.create :question}
    before {request.env["HTTP_REFERER"] = "/admins/questions"}

    it "success" do
      delete :destroy, id: question.id
      expect(response).to redirect_to admins_questions_path
      expect(flash[:success]).to be_present
    end

    it "fail" do
      delete :destroy, id: 0
      expect(response).to redirect_to admins_questions_path
    end
  end
end
