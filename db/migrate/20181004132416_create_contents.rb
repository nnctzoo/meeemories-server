class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.bigint :media_id,   null: false
      t.string :media_type, null: false

      t.timestamps null: false
    end
  end
end
