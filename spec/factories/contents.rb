FactoryBot.define do
  factory :content do
    association :media, factory: :picture
  end
end
