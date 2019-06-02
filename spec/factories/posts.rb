# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'MyString' }
    subtitle { 'MyText' }
    author { nil }
    content { 'MyText' }
  end
end
