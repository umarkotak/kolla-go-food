# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    kode 'PERCENTX'
    valid_from '2017-11-1'
    valid_through '2017-11-25'
    amount '15'
    unit 'percent'
    max_amount '20000'
  end
end
