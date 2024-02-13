FactoryBot.define do
  factory :item do
    name { Faker::Company.name }
    metadata { { name:, foo: :bar } }
  end
end
