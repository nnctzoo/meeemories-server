FactoryBot.define do
  factory :video_transcoding_job do
    association :video_transcoding

    key { Faker::Number.hexadecimal }
  end
end
