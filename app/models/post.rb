# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :categories

  has_rich_text :content
end
