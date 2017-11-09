# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    kode 'PERCENTX'
    valid_from '2017-11-1'
    valid_through '2017-12-25'
    amount '15'
    unit 'percent'
    max_amount '20000'
  end

  factory :invalid_voucher, parent: :voucher do
    kode nil
    valid_from nil
    valid_through nil
    amount nil
    unit nil
    max_amount nil
  end
end
