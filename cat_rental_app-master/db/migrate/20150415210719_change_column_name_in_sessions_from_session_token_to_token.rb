class ChangeColumnNameInSessionsFromSessionTokenToToken < ActiveRecord::Migration
  def change
    rename_column :sessions, :session_token, :token
  end
end
