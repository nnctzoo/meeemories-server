class Picture < ApplicationRecord
  has_many :sources, as: :media
end
