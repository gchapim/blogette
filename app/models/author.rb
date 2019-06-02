# frozen_string_literal: true

class Author < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :user, presence: true
end
