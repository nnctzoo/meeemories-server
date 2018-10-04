class CreateTranscodedVideos < ActiveRecord::Migration[5.2]
  def change
    create_table :transcoded_videos do |t|
      t.timestamps null: false
    end
  end
end
