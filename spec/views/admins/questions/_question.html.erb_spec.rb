require "rails_helper"
include RspecHelper

RSpec.describe "admins/questions/_question", :type => :view do
  let(:admin) {FactoryGirl.create :admin}
  before {log_in admin}

  describe "question" do
    let(:question) {FactoryGirl.create :question}
    context "will be rendered _question partial" do
      before do
        render "admins/questions/question", question: question
      end
      it {expect(rendered).to have_link question.content}
      it {expect(rendered).to have_link "Edit"}
      it {expect(rendered).to have_link "Delete"}
    end
  end
end
