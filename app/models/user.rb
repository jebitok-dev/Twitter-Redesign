class User < ApplicationRecord
  has_many :opinions, foreign_key: :author_id, class_name: 'Opinion', dependent: :destroy, inverse_of: 'author'

  has_many :followers, foreign_key: :follower_id, class_name: 'Follow'
  has_many :user_followers, through: :followers, source: :follower

  has_many :followings, foreign_key: :following_id, class_name: 'Follow'
  has_many :user_followings, through: :followings, source: :following

  validates :username, presence: true, uniqueness: true

  def self.all_users(user_id)
    User.where('id != ?', user_id)
  end

  def not_following
    User.all.where.not(id: user_followings.select(:id)).where.not(id: id).order(created_at: :desc)
  end

  def follow_user(user_id)
    @follow = Follow.create(follower_id: id, following_id: user_id)
    @user = User.find(user_id)
    @user.count_following += 1
    self.count_follower += 1
    @user.save
    self.save
  end

  def already_follow?(user_id)
    true if Follow.find_by(follower_id: id, following_id: user_id)
  end
end
