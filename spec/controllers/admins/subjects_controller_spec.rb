require "rails_helper"

RSpec.describe Admins::SubjectsController, type: :controller do
  let(:admin) {FactoryGirl.create :admin}
  let :attr_true do
    FactoryGirl.attributes_for :subject, content: Faker::Lorem.sentence,
    duration: 30, number_of_questions: 20
  end
  let :attr_false do FactoryGirl.attributes_for :subject,
    content: Faker::Lorem.sentence, duration: 30, number_of_questions: nil
  end

  before {sign_in admin}

  describe "#new" do
    it do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "#show" do
    let(:subject) {FactoryGirl.create :subject}
    it do
      get :show, id: subject.id
      expect(response).should render_template "admins/subjects/show"
    end
  end

  describe "#index" do
    it do
      get :index
      expect(response).to render_template "admins/subjects/index"
    end

    let(:subject) {FactoryGirl.create :subject}
    let(:other_subject) {FactoryGirl.create :subject}

    it "loads all of subjects" do
      get :index
      expect(assigns :subjects).to match_array [subject, other_subject]
    end
  end

  describe "#create" do
    it "crete success" do
      post :create, subject: attr_true
      expect(response).to redirect_to admins_subjects_path
    end

    it "create fail" do
      post :create, subject: attr_false
      expect(response).to render_template :new
    end
  end

  describe "#edit" do
    let(:subject) {FactoryGirl.create :subject}

    it do
      get :edit, id: subject.id
      expect(response).to render_template :edit
    end
  end

  describe "#update" do
    let(:subject) {FactoryGirl.create :subject}

    it "update success" do
      patch :update, id: subject.id, subject: attr_true
      expect(flash[:success]).to be_present
      expect(response).to redirect_to admins_subjects_path
    end

    it "update fail" do
      patch :update, id: subject.id, subject: attr_false
      expect(flash[:danger]).to be_present
      expect(response).to render_template :edit
    end
  end

  describe "#destroy" do
    let(:subject) {FactoryGirl.create :subject}

    it "success" do
      delete :destroy, id: subject.id
      expect(flash[:success]).to be_present
      expect(response).to redirect_to admins_subjects_path
    end

    it "fail" do
      delete :destroy, id: 0
      expect(flash[:danger]).to be_present
      expect(response).to redirect_to admins_subjects_path
    end
  end
end
