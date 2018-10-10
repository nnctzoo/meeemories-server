FactoryBot.define do
  factory :picture do
    key { Faker::Number.hexadecimal(16) }

    trait :with_sources do
      after(:create) do |picture|
        create_list(:source, 3, media: picture)
      end
    end
  end
end
