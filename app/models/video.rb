class Video < ApplicationRecord
  has_many :sources, as: :media
end
