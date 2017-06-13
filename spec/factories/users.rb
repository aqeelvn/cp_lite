FactoryGirl.define do
  factory :user do
    username "test"
    email "test@example.com"
    password_digest "testpassword"
  end
end
