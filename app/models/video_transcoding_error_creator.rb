class VideoTranscodingErrorCreator
  def initialize(message)
    @message = JSON.parse(message)
  end

  def run
    verify_message!

    job = VideoTranscodingJob.find_by!(key: @message['jobId'])
    VideoTranscodingError.create!(error_code: @message['errorCode'], video_transcoding_id: job.video_transcoding_id)
  end

  private

  def verify_message!
    raise InvalidState if @message['state'] != 'ERROR'
  end

  InvalidState = Class.new(StandardError)
end
