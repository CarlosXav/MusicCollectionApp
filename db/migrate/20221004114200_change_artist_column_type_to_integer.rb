class ChangeArtistColumnTypeToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :albums, :artist, :integer
  end
end
