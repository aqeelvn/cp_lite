FactoryGirl.define do
  sequence :username do |n|
    "person#{n}"
  end

  sequence :email do |n|
    "email#{n}@example.com"
  end

  factory :user do
    username
    email
    password_digest "testpassword"

    trait :with_token do
      transient do
        tokens_count 1
      end

      after(:create) do |user, evaluator|
        create :access_token, user: user
      end
    end
  end
end
