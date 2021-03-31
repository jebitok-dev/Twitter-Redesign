require 'rails_helper'

feature 'User login the app' do
  let(:user) do
    User.create(username: 'user1', fullname: 'name1',
                photo: 'link', coverimage: 'link')
  end

  scenario 'the user posts in the home page' do
    visit login_path

    fill_in 'username', with: user.username
    click_button 'login'

    visit home_path

    fill_in 'text', with: 'tweet'
    click_button 'submit'

    expect(page).to have_text user.username
  end

  scenario 'following users are shown in home page' do
    visit login_path

    fill_in 'username', with: user.username
    click_button 'login'

    visit home_path

    expect(page).to have_text user.followings.all.count
  end

  scenario 'followers are shown in home page' do
    visit login_path

    fill_in 'username', with: user.username
    click_button 'login'

    visit home_path

    expect(page).to have_text user.followers.all.count
  end
end
