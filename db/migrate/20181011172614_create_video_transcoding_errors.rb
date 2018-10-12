class CreateVideoTranscodingErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :video_transcoding_errors do |t|
      t.references :video_transcoding, null: false, index: false
      t.string :key, null: false
      t.string :error_code

      t.timestamps null: false

      t.index [:video_transcoding_id], unique: true
      t.index [:key], unique: true
    end
  end
end
