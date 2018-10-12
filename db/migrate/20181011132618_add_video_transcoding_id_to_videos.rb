class AddVideoTranscodingIdToVideos < ActiveRecord::Migration[5.2]
  def change
    add_column :videos, :video_transcoding_id, :bigint, null: false
    add_index :videos, [:video_transcoding_id], unique: true
  end
end
