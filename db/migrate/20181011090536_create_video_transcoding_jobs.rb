class CreateVideoTranscodingJobs < ActiveRecord::Migration[5.2]
  def change
    create_table :video_transcoding_jobs do |t|
      t.references :video_transcoding, null: false, index: false
      t.string :key, null: false

      t.timestamps null: false

      t.index [:video_transcoding_id], unique: true
      t.index [:key], unique: true
    end
  end
end
