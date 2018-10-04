class CreateSources < ActiveRecord::Migration[5.2]
  def change
    create_table :sources do |t|
      t.bigint  :media_id,   null: false
      t.string  :media_type, null: false
      t.integer :width,      null: false
      t.integer :height,     null: false
      t.string  :mime_type,  null: false

      t.timestamps null: false
    end
  end
end
