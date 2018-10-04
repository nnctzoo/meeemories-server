class Source < ApplicationRecord
  belongs_to :media, polymorphic: true
end
