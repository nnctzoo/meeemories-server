class TranscodedVideo < ApplicationRecord
  has_many :sources, as: :media
end
