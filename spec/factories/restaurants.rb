# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    # name 'Waroenk Kito'
    sequence :name do |n|
      "name#{n}"
    end
    address 'Bogor'
  end
end
