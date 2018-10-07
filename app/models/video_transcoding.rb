# VideoTranscoding is not a Media, but treated as a Media for convenience
class VideoTranscoding < ApplicationRecord
  has_one_attached :file

  def sources
    []
  end

  def pending?
    true
  end

  def available?
    false
  end
end
