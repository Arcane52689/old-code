class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activated, :boolean
    add_column :users, :activation_token, :string
  end
end
