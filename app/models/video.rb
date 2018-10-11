class Video < ApplicationRecord
  belongs_to :video_transcoding

  has_many :sources, as: :media

  def pending?
    false
  end

  def available?
    true
  end
end
