class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.string :name
      t.date :release
      t.string :genre
      t.string :description
      t.string :image
      t.references :artist, foreign_key: true

      t.timestamps
    end
  end
end
