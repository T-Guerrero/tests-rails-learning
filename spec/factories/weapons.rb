FactoryBot.define do
  factory :weapon do
    name { FFaker::Lorem.word }
    description { FFaker::Lorem.phrase }
    power_base { FFaker::Random.rand(1000..10000) }
    power_step { FFaker::Random.rand(10..1000) }
  end
end
