class RemoveSessionTokensFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :session_token
  end
end
