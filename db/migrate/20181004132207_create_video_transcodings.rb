class CreateVideoTranscodings < ActiveRecord::Migration[5.2]
  def change
    create_table :video_transcodings do |t|
      t.timestamps null: false
    end
  end
end
