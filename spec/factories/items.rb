FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    metadata { { name:, foo: :bar }.to_json }
  end
end
