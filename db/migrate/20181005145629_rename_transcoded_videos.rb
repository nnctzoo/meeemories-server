class RenameTranscodedVideos < ActiveRecord::Migration[5.2]
  def change
    rename_table :transcoded_videos, :videos
  end
end
