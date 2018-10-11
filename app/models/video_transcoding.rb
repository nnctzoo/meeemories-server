# VideoTranscoding is not Media, but treated as Media for convenience
class VideoTranscoding < ApplicationRecord
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
