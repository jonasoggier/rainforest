# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    email "example@example.com"
    password_digest "abc123"
  end
end
