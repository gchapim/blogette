FactoryBot.define do
  factory :author do
    firstname { "MyString" }
    lastname { "MyString" }
    bio { "MyText" }
    user { nil }
    website { "MyString" }
  end
end
