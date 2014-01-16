# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :bad_customer_comment do
    bad_customer_id 1
    user_id 1
    body "MyText"
    deleted false
  end
end
