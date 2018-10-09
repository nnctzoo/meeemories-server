class Picture < ApplicationRecord
  has_many :sources, as: :media

  def generate_key
    begin
      key = SecureRandom.hex
    end while self.class.exists?(key: key)
    self.key = key
  end
end
