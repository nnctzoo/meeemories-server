class AddKeyToPictures < ActiveRecord::Migration[5.2]
  def change
    add_column :pictures, :key, :string, null: false
    add_index :pictures, [:key], unique: true
  end
end
