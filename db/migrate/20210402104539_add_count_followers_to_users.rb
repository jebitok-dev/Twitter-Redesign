class AddCountFollowersToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :count_followers, :integer, :default => 0
  end
end
