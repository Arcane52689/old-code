class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.string :device
      t.string :ip
      t.string :session_token, null: false

      t.timestamps null: false
    end

    add_index :sessions, :session_token, unique: true

  end
end
