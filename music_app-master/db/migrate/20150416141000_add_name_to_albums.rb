class AddNameToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :name, :string
    add_index :albums, :name
  end
end
