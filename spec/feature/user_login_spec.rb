require 'rails_helper'

feature 'User login the app' do
  let(:user) { User.create(username: 'user1', fullname:'name1',
                        photo: 'link', coverimage: 'link') }

  scenario 'user login succesfully' do
    visit login_path

    fill_in 'username', with: user.username
    click_button 'login'

    expect(page).to have_text user.username
  end

  scenario 'user cant login without valid information' do
    visit login_path

    fill_in 'username', with: 'username'
    click_button 'login'

    expect(page).to have_text 'Please verify your submission'
  end

  scenario 'user cant login with no data' do
    visit login_path

    fill_in 'username', with: ''
    click_button 'login'

    expect(page).to have_text 'Please verify your submission'
  end
end