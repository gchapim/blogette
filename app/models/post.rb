# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :author
  has_and_belongs_to_many :categories
  has_rich_text :content

  scope :active, -> { where(active: true) }

  before_save :publish, if: -> { active_changed? }

  validates :author, presence: true
  validates :content, presence: true
  validates :title, presence: true

  private

  def publish
    return unless active?

    self.published_at = Time.current
  end
end
