class RemoveKeyFromVideoTranscodingErrors < ActiveRecord::Migration[5.2]
  def change
    remove_column :video_transcoding_errors, :key
  end
end
