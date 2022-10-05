class Add < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :creator_id, :integer
  end
end
