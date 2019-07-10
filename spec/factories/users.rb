FactoryBot.define do
  factory :user do
    name { "josie" }
    email { "josie@test.abc" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now }
  end
end
