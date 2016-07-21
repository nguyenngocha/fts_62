require "rails_helper"

RSpec.describe Question, type: :model do
  describe "Associations" do
    it {is_expected.to belong_to :subject}
    it {is_expected.to have_one :suggested_question}
    it {is_expected.to have_many :answers}
    it {is_expected.to have_many :results}
  end

  describe "Enums" do
    it {is_expected.to define_enum_for :question_type}
    it {is_expected.to define_enum_for :status}
  end

  it "scope random" do
    Question.random.to_sql.should eq(Question.order("RANDOM()").to_sql)
  end
end
