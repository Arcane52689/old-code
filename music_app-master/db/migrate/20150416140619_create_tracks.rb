class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :name
      t.references :album, index: true, foreign_key: true
      t.boolean :bonus
      t.text :lyrics

      t.timestamps null: false
    end
  end
end
