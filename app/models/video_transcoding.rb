# VideoTranscoding is not Media, but treated as Media for convenience
class VideoTranscoding < ApplicationRecord
  has_one :video_transcoding_job
  has_one :video_transcoding_error
  has_one :video

  has_one_attached :file

  def sources
    []
  end

  def pending?
    video.nil? && video_transcoding_error.nil?
  end

  def available?
    !video.nil?
  end
end
