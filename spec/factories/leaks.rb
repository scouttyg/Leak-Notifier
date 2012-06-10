# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :leak do
    service_name "MyString"
    service_id 1
    first_reported "2012-06-09 16:40:45"
  end
end
