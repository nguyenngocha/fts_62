require "rails_helper"

RSpec.describe Subject, type: :model do
  describe "Associations" do
    it {is_expected.to have_many :questions}
    it {is_expected.to have_many :exams}
  end

  describe "Validations" do
    it {is_expected.to validate_presence_of :content}
    it {is_expected.to validate_presence_of :number_of_questions}
    it {is_expected.to validate_presence_of :duration}
  end
end
