class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.string :url
      t.string :size
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
