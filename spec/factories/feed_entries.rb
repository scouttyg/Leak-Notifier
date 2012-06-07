# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feed_entry do
    name "MyString"
    summary "MyText"
    url "MyString"
    published_at "2012-06-07 16:20:00"
    guid "MyString"
  end
end
