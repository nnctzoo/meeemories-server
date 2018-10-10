# VideoTranscoding is not a Media, but treated as a Media for convenience
class VideoTranscoding < ApplicationRecord
  def sources
    []
  end

  def available?
    false
  end
end
