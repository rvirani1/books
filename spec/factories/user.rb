FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password "awfulPass"
    password_confirmation "awfulPass"
    confirmed_at (1..5).to_a.sample.hour.ago
  end
end
