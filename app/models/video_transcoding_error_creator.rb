class VideoTranscodingErrorCreator
  def initialize(message)
    @message = JSON.parse(message)
    @error_code = @message['errorCode']
  end

  def run
    verify_message!

    job = VideoTranscodingJob.find_by!(key: @message['jobId'])
    @video_transcoding_error = VideoTranscodingError.create!(key: job.key, error_code: @error_code, video_transcoding_id: job.video_transcoding_id)
  end

  def verify_message!
    raise InvalidState if @message['state'] != 'ERROR'
  end
end