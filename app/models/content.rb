class Content < ApplicationRecord
  belongs_to :media, polymorphic: true
end
