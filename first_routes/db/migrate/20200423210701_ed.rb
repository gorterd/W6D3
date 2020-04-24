class Ed < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :favorite_id, :integer
    add_index :users, :favorite_id
  end
end
