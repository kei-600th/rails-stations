FactoryBot.define do
  factory :review do
    association :user, factory: :user
    association :movie, factory: :movie
    sequence(:comment) { |n| "TEST_COMMENT#{n}" }
    evaluation { rand(1..5) }
  end
end