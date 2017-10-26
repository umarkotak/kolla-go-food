FactoryGirl.define do
  factory :buyer do
    name 'M Umar Ramadhana'
    email 'umarkotak@yahoo.co.id'
    phone '085217251690'
    address 'Bogor'
  end

  factory :invalid_buyer, parent: :buyer do
    name nil
    email nil
    phone nil
    address nil
  end
end