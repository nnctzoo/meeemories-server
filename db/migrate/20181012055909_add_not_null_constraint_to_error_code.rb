class AddNotNullConstraintToErrorCode < ActiveRecord::Migration[5.2]
  def up
    change_column_null :video_transcoding_errors, :error_code, false
  end
end
