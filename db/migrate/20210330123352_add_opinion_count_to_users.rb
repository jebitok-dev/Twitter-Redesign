class AddOpinionCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :opinion_count, :integer, default: 0
  end
end
