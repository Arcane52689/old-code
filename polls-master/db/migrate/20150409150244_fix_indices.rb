class FixIndices < ActiveRecord::Migration
  def change

    change_table "users" do |t|
      t.remove_index :user_name
    end

    add_index :users, :user_name, unique: true
  end
end
