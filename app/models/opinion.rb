class Opinion < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  validates :text, presence: true, length: { maximum: 280 }
  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :newsfeed_opinions, -> { includes(:author).ordered_by_most_recent }
end
