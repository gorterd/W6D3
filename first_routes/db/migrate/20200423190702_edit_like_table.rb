class EditLikeTable < ActiveRecord::Migration[5.2]
  def change
    add_column :likes, :likable_id, :integer, null: false
    add_column :likes, :likable_type, :string, null: false
    add_index :likes, [:likable_id, :likable_type], unique: true

    remove_column :likes, :artwork_id
    # remove_index :likes, :artwork_id
  end
end
