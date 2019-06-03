# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    firstname { 'MyString' }
    lastname { 'MyString' }
    bio { 'MyText' }
    user
    website { 'MyString' }
  end
end
