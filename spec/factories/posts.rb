# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'MyString' }
    subtitle { 'MyText' }
    author
    content { 'MyText' }
  end
end
