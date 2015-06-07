class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.references :band, index: true, foreign_key: true
      t.boolean :live

      t.timestamps null: false
    end
  end
end
