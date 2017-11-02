FactoryGirl.define do
  factory :user do
    username 'm umar ramadhana'
    password '123456789'
    password_confirmation '123456789'
  end

  factory :invalid_user, parent: :user do
    username nil
    password nil
    password_confirmation nil
  end
end