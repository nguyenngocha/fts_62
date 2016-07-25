require "rails_helper"
include RspecHelper

RSpec.describe "admins/subjects/new", :type => :view do
  let(:admin) {FactoryGirl.create :admin}
  before {log_in admin}

  describe "subject" do
    it "will be rendered new subject form" do
      visit new_admins_subject_path
      expect(page).to have_button "New Subject"
    end
  end
end
