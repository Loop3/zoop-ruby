FactoryBot.define do
  factory :buyer, class: Zoop::Buyer do
    sequence(:first_name) { |n| "Buyer #{n}" }
    last_name 'Zoop'
    sequence(:email) { |n| "buyer#{n}@mail.com" }
    taxpayer_id { Faker::CPF.numeric }
  end
end
