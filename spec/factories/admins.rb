FactoryGirl.define do
  factory :admin do
    email Faker::Internet.email
    name Faker::Name.name
    password "password"
    password_confirmation "password"
    chatwork_id "123456789"
  end
end
