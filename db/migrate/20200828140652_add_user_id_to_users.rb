class AddUserIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :goals, :user_id, :bigint
  end
end
