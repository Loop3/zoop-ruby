FactoryBot.define do
  factory :card_token, class: Zoop::Token do
    holder_name 'Rodrigo M R Pereira'
    card_number '5356066320271893'
    expiration_month '03'
    expiration_year '2020'

    trait :created do
      sequence(:id) { |n| "#{n}" }
      card { FactoryBot.build :card, :created }
    end
  end

  factory :bank_account_token, class: Zoop::Token do
    holder_name 'Rodrigo M R Pereira'
    bank_code 341
    routing_number 3730
    account_number 310851
    type 'checking'

    trait :saving do
      type 'savings'
    end

    trait :individual do
      taxpayer_id { Faker::CPF.numeric }
    end

    trait :business do
      ein { Faker::CNPJ.numeric }
    end

    trait :created_individual do
      sequence(:id) { |n| "#{n}" }
      bank_account { FactoryBot.build :bank_account, :individual, :created }
    end

    trait :created_business do
      sequence(:id) { |n| "#{n}" }
      bank_account { FactoryBot.build :bank_account, :business, :created }
    end
  end
end
