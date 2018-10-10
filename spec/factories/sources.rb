FactoryBot.define do
  factory :source do
    url { Faker::LoremPixel.image('200x200') }
    mime_type { 'image/jpeg' }
    width { 200 }
    height { 200 }
  end
end
