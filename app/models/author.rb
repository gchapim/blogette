# frozen_string_literal: true

class Author < ApplicationRecord
  belongs_to :user
  has_many :posts

  validates :user, presence: true
  validates :firstname, presence: true

  def name
    [firstname, lastname].compact.join(' ')
  end
end
