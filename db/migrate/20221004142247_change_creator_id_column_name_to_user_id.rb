class ChangeCreatorIdColumnNameToUserId < ActiveRecord::Migration[7.0]
  def change
    rename_column :albums, :creator_id, :user_id
  end
end
