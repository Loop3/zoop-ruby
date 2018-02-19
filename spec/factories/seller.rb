FactoryBot.define do
  factory :seller, class: Zoop::Seller do
    sequence(:first_name) { |n| "Seller #{n}" }
    last_name 'Zoop'
    sequence(:email) { |n| "seller#{n}@mail.com" }

    trait :individual do
      taxpayer_id { Faker::CPF.numeric }
      type 'individual'
    end

    trait :business do
      ein { Faker::CNPJ.numeric }
      type 'business'
    end
  end
end
