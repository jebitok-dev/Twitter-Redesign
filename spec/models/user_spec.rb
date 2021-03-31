require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user1) do
    User.new(username: 'user1', fullname: 'name1',
             photo: 'link', coverimage: 'link')
  end
  let(:user2) do
    User.new(username: 'user2', fullname: 'name2',
             photo: 'link', coverimage: 'link')
  end
  describe 'validates user attributes' do
    it 'validates if the user is valid' do
      expect(user1.valid?).to eql(true)
    end
    it 'validates if the username is present' do
      user1.username = ' '
      expect(user1.valid?).not_to eql(true)
    end
    it 'validates if the fullname is present' do
      user1.fullname = ' '
      expect(user1.valid?).not_to eql(true)
    end
    it 'validates if the name is not too long' do
      user1.fullname = 'a' * 61
      expect(user1.valid?).not_to eql(true)
    end
    it 'validates if the usernames are unique' do
      duplicate_user = user1.dup
      user1.save
      expect(duplicate_user.valid?).not_to eql(true)
    end
    it 'validates if the usernames are saved as lower-case' do
      mixed_case_username = 'UsErNaME'
      user1.username = mixed_case_username
      user1.save
      expect(mixed_case_username.downcase == user1.reload.username).to eql(true)
    end
  end

  describe 'validates Follow associations' do
    it 'validates if user is added to users followings' do
      user1.save
      user2.save
      Follow.create(follower_id: user1.id, following_id: user2.id)
      expect(user1.already_follow?(user2.id)).to eql(true)
    end
  end
end
