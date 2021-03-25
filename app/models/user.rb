class User < ApplicationRecord
  has_many :opinions, foreign_key: :author_id, class_name: 'Opinion', dependent: :destroy, inverse_of: 'author'

  validates :username, presence: true, uniqueness: true
end
